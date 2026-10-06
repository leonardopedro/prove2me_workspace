-- Generated from ChapterSmBrstGhost.lean — theorem BookProof.SmBrstGhost.ghostNumber_comm_ghostCre
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterYangMillsSU3
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
import Definitions.Def_ChapterNavierStokes
import Definitions.Def_ChapterNavierStokesFockSpace
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.NavierStokes
open BookProof.NavierStokesFlow.FockOfFock
open BookProof.SmCar
open BookProof.SmBrstGhost

variable {m : ℕ}



open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

theorem BookProof.SmBrstGhost.ghostNumber_comm_ghostCre (m : ℕ) (a : Fin 12) :
    ghostNumber m * ghostCre m a - ghostCre m a * ghostNumber m = ghostCre m a := by sorry
