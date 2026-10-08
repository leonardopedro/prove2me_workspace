-- Generated from ChapterCoherentDynamics.lean — theorem BookProof.ChapterCoherentDynamics.bornWeightC_evolution_const
import Definitions.Def_ChapterCoherentFidelity
import Mathlib
import Definitions.Def_ChapterCoherentDynamics
import Definitions.Def_ChapterCoherentOverlapComplex
open BookProof.ChapterCoherentOverlapComplex
open BookProof.ChapterCoherentDynamics


open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex BookProof.ChapterCoherentFidelity

variable {n m : ℕ}


theorem BookProof.ChapterCoherentDynamics.bornWeightC_evolution_const (omega : ℝ) (q : EuclideanSpace ℂ (Fin n))
    (k : Fin m → EuclideanSpace ℂ (Fin n)) (j : Fin m) (t : ℝ) :
    bornWeightC (phaseRotate (-(omega * t)) q)
        (fun l => phaseRotate (-(omega * t)) (k l)) j
      = bornWeightC q k j := by sorry
