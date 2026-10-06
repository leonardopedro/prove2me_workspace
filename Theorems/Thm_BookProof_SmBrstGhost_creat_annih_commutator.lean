-- Generated from ChapterSmBrstGhost.lean — theorem BookProof.SmBrstGhost.creat_annih_commutator
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
variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {N : ℕ}



open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

theorem BookProof.SmBrstGhost.creat_annih_commutator (i j k l : Fin N) :
    (creat i * annih j : Module.End ℂ (FermiFock N)) * (creat k * annih l)
        - (creat k * annih l) * (creat i * annih j)
      = (if j = k then (creat i * annih l : Module.End ℂ (FermiFock N)) else 0)
        - (if l = i then (creat k * annih j : Module.End ℂ (FermiFock N)) else 0) := by sorry
