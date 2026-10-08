-- Generated from ChapterSmBrstGhost.lean — theorem BookProof.SmBrstGhost.annih_sq
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

theorem BookProof.SmBrstGhost.annih_sq {N : ℕ} (i : Fin N) :
    (annih i : Module.End ℂ (FermiFock N)) * annih i = 0 := by sorry
