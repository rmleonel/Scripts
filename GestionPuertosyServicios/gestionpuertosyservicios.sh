#!/bin/bash

while true; do
    echo "=== Gestión de Servicios y Firewall ==="
    echo "1) Listar servicios"
    echo "2) Iniciar servicio"
    echo "3) Detener servicio"
    echo "4) Ver estado de UFW y servicios en los puertos"
    echo "5) Abrir puerto en UFW"
    echo "6) Cerrar puerto en UFW"
    echo "7) Salir"
    
    read -p "Seleccione una opción: " opcion

    case $opcion in
        1)
            while true; do
                echo "=== Lista de Servicios ==="
                systemctl list-units --type=service --no-pager
                echo ""
                echo "a) Iniciar servicio"
                echo "b) Detener servicio"
                echo "c) Volver atrás"
                read -p "Seleccione una opción: " subopcion
                
                case $subopcion in
                    a)
                        read -p "Servicio a iniciar: " svc
                        if [[ -n "$svc" ]]; then
                            read -p "¿Está seguro de que desea iniciar el servicio $svc? (s/n): " confirm
                            if [[ $confirm == "s" || $confirm == "S" ]]; then
                                sudo systemctl start "$svc" && echo "Servicio $svc iniciado." || echo "Error al iniciar $svc."
                            fi
                        else
                            echo "El nombre del servicio no puede estar vacío."
                        fi
                        ;;
                    b)
                        read -p "Servicio a detener: " svc
                        if [[ -n "$svc" ]]; then
                            read -p "¿Está seguro de que desea detener el servicio $svc? (s/n): " confirm
                            if [[ $confirm == "s" || $confirm == "S" ]]; then
                                sudo systemctl stop "$svc" && echo "Servicio $svc detenido." || echo "Error al detener $svc."
                            fi
                        else
                            echo "El nombre del servicio no puede estar vacío."
                        fi
                        ;;
                    c)
                        break
                        ;;
                    *)
                        echo "Opción no válida."
                        ;;
                esac
            done
            ;;
        2)
            read -p "Servicio a iniciar: " svc
            [[ -n "$svc" ]] && sudo systemctl start "$svc" && echo "Servicio $svc iniciado." || echo "Error al iniciar el servicio."
            ;;
        3)
            read -p "Servicio a detener: " svc
            [[ -n "$svc" ]] && sudo systemctl stop "$svc" && echo "Servicio $svc detenido." || echo "Error al detener el servicio."
            ;;
        4)
            echo "=== Estado de UFW ==="
            sudo ufw status verbose
            echo "\n=== Servicios en los puertos abiertos ==="
            sudo ss -tulnp | awk 'NR>1 {split($5,a,":"); print "Protocolo:", $1, "| Puerto:", a[length(a)], "| Servicio:", $7}'
            ;;
        5)
            read -p "Puerto a abrir: " port
            if [[ "$port" =~ ^[0-9]+$ ]]; then
                read -p "¿Está seguro de que desea abrir el puerto $port? (s/n): " confirm
                if [[ $confirm == "s" || $confirm == "S" ]]; then
                    sudo ufw allow "${port}/tcp" && echo "Puerto $port abierto." || echo "Error al abrir el puerto."
                fi
            else
                echo "Debe ingresar un número de puerto válido."
            fi
            ;;
        6)
            read -p "Puerto a cerrar: " port
            if [[ "$port" =~ ^[0-9]+$ ]]; then
                read -p "¿Está seguro de que desea cerrar el puerto $port? (s/n): " confirm
                if [[ $confirm == "s" || $confirm == "S" ]]; then
                    sudo ufw deny "${port}/tcp" && echo "Puerto $port cerrado." || echo "Error al cerrar el puerto."
                fi
            else
                echo "Debe ingresar un número de puerto válido."
            fi
            ;;
        7)
            echo "Saliendo..."
            exit 0
            ;;
        *)
            echo "Opción no válida."
            ;;
    esac
    
    echo ""
done

