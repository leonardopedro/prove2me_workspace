-- Generated from ChapterMassGap.lean — theorem BookProof.MassGap.exp_conj_eq_self
import Mathlib
import Definitions.Def_ChapterMassGap
open BookProof.MassGap

variable {𝔸 : Type*} [NormedRing 𝔸] [NormedAlgebra ℂ 𝔸] [CompleteSpace 𝔸]



open scoped BigOperators

theorem BookProof.MassGap.exp_conj_eq_self {Obs Y : 𝔸} (h : Commute Obs Y) :
    NormedSpace.exp Y * Obs * NormedSpace.exp (-Y) = Obs := by sorry
