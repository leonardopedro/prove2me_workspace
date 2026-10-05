-- Generated from ChapterF1.lean — solution of BookProof.ChapterF1.symmetric_ordering_vacuum
import Mathlib
import Definitions.Def_ChapterF1
open BookProof.ChapterF1



open Polynomial Finset
open scoped BigOperators


noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : hamiltonianSym (1 : ℂ[X]) = (2⁻¹ : ℂ) • (1 : ℂ[X]) := by

  unfold hamiltonianSym; norm_num
