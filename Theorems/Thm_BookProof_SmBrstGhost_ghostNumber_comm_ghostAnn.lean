-- Generated from ChapterSmBrstGhost.lean — theorem BookProof.SmBrstGhost.ghostNumber_comm_ghostAnn
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



open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

variable {m : ℕ}

theorem BookProof.SmBrstGhost.ghostNumber_comm_ghostAnn (m : ℕ) (a : Fin 12) :
    ghostNumber m * ghostAnn m a - ghostAnn m a * ghostNumber m = -ghostAnn m a := by sorry
