-- Generated from ChapterSmBrstGhost.lean — theorem BookProof.SmBrstGhost.creat_mul_creat
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterYangMillsSU3
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
import Definitions.Def_ChapterNavierStokesFockSpace
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.NavierStokesFlow.FockOfFock
open BookProof.SmCar
open BookProof.SmBrstGhost

variable {m : ℕ}



open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

theorem BookProof.SmBrstGhost.creat_mul_creat {N : ℕ} (p q : Fin N) :
    (creat p : Module.End ℂ (FermiFock N)) * creat q = -(creat q * creat p) := by sorry
