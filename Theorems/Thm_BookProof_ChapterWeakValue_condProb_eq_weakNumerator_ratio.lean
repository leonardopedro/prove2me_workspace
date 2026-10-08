-- Generated from ChapterWeakValue.lean — theorem BookProof.ChapterWeakValue.condProb_eq_weakNumerator_ratio
import Mathlib
import Definitions.Def_ChapterWeakValue
import Definitions.Def_ChapterTrajectory
open BookProof.ChapterTrajectory
open BookProof.ChapterWeakValue


open scoped BigOperators Matrix


variable {n : ℕ}

open BookProof.ChapterTrajectory

theorem BookProof.ChapterWeakValue.condProb_eq_weakNumerator_ratio (U V : Matrix (Fin n) (Fin n) ℂ)
    (psi : Fin n → ℂ) (f a : Fin n) :
    condProb U V psi f a =
      ‖ip (postSelect V f) (projMat a *ᵥ (U *ᵥ psi))‖ ^ 2 /
        ∑ b, ‖ip (postSelect V f) (projMat b *ᵥ (U *ᵥ psi))‖ ^ 2 := by sorry
