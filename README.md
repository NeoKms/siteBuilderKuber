# Автоматическое развертывание мастер-ноды кубернетес. 
# Для запуска: sh initkuber.sh
# kubelet=1.18.0-00 kubectl=1.18.0-00 kubeadm=1.18.0-00 
# Используется:
- flanel
- ingress
- portainer (NodePort: 30777)
- auto nfs (имя класса: autonfs. Тестовый PVC 1Mi: nfs)
# Для подключения к гитлабу выводится ip, cert, admin token
---
# Работа с job-тестами:
*kubectl describe jobs* - вывести всю информацию о работах

*kubectl describe jobs | grep Name:* - вывести только названия работ для удаления\получения логов

*kubectl delete jobs/{name}* - удалить работу

*kubectl logs $(kubectl get pods -n default --selector=job-name={name} --output=jsonpath='{.items[*].metadata.name}')* - получить под по названию работы и вывести из него лог
