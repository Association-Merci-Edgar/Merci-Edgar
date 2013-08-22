# language: fr
Fonctionnalité: Création d'une tâche
  Afin d'être mieux organisé
  En tant qu'utilisateur de Merci Edgar
  Je souhaite pouvoir créer des tâches
  
  Plan du Scénario: Création d'une tâche liée à une salle
    Etant donné que je suis connecté
    Et que je regarde la fiche d'une salle
    Lorsque je clique sur "Ajouter une tâche"
    Et que je donne <description> comme description
    Et que je choisis <qui> comme "Assigné à" 
    Et que je remplis "Quand" par <quand>
    Et que je choisis <type> comme type
    Et que je clique sur le bouton "Ajouter"
    Alors je devrais voir <message>
    
    Exemples:
      | description          | qui   | quand           | type    | message   |
      | "Inviter au concert" | "Moi" | "Cette semaine" | "Email" | "succès"  |