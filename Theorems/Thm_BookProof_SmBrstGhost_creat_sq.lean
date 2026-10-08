-- Generated from ChapterSmBrstGhost.lean — theorem BookProof.SmBrstGhost.creat_sq
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterYangMillsSU3
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
import Definitions.Def_ChapterNavierStokesFockSpace
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.SmCar
open BookProof.SmBrstGhost



open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

variable {m : ℕ}

theorem BookProof.SmBrstGhost.creat_sq {N : ℕ} (i : Fin N) :
    (creat i : Module.End ℂ (FermiFock N)) * creat i = 0 := by sorry
