-- Generated from ChapterGaugeShiftExample.lean — theorem BookProof.ChapterGaugeShiftExample.shift_unconstrained_gauge_fixing_headline
import Mathlib
import Definitions.Def_ChapterGaugeShiftExample
import Definitions.Def_ChapterContinuityUnitary
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterNavierStokesFullEsa
open BookProof.ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.NavierStokesFlow.FullEsa
open BookProof.NavierStokesFlow.FullEsa.NSFullData
open BookProof.ChapterGaugeShiftExample


open scoped InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite

theorem BookProof.ChapterGaugeShiftExample.shift_unconstrained_gauge_fixing_headline :
    (∀ v w : LinfZ, velocityOp v * velocityOp w = velocityOp w * velocityOp v) ∧
    (∀ (v : LinfZ) (j : ℤ),
      velocityOp v (basisVecL2 j) = ((v : ℤ → ℝ) j : ℂ) • basisVecL2 j) ∧
    (∀ m : ℤ, m ≠ 0 → ∀ v : LinfZ, shiftOp m ≠ velocityOp v) ∧
    (∀ m j : ℤ, shiftOp m (basisVecL2 j) = basisVecL2 (j - m) ∧
      basisVecL2 (j - m) ≠ 0) := by sorry
