-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.wt_mono
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
open BookProof.HermiteLadder




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {m m' : ℕ} (h : m ≤ m') (a : Fin d →₀ ℕ) : wt m a ≤ wt m' a := pow_le_pow_right₀ (by exact_mod_cast Nat.succ_pos _) h
