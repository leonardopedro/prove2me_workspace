-- Generated from ChapterWeakValue.lean — theorem BookProof.ChapterWeakValue.jointProb_eq_normSq_weakNumerator
import Mathlib
import Definitions.Def_ChapterWeakValue
import Definitions.Def_ChapterTrajectory
open BookProof.ChapterTrajectory
open BookProof.ChapterWeakValue


open scoped BigOperators Matrix


variable {n : ℕ}

open BookProof.ChapterTrajectory

theorem BookProof.ChapterWeakValue.jointProb_eq_normSq_weakNumerator (U V : Matrix (Fin n) (Fin n) ℂ)
    (psi : Fin n → ℂ) (f a : Fin n) :
    ‖ip (postSelect V f) (projMat a *ᵥ (U *ᵥ psi))‖ ^ 2 = jointProb U V psi f a := by sorry
