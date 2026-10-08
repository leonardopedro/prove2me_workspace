-- Generated from ChapterSmBrstGhost.lean — theorem BookProof.SmBrstGhost.occupation_occ
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterYangMillsSU3
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
import Definitions.Def_ChapterNavierStokesFockSpace
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.NavierStokesFlow.FockOfFock
open BookProof.SmCar
open BookProof.SmBrstGhost



open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

variable {m : ℕ}

theorem BookProof.SmBrstGhost.occupation_occ {N : ℕ} (i : Fin N) (S : Finset (Fin N)) :
    creat i (annih i (occ S)) = if i ∈ S then occ S else 0 := by sorry
