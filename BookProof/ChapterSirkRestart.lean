import Mathlib
import BookProof.ChapterH6

/-!
# Chapter SirkRestart — the restart cycle and its accumulated error

`CONSOLIDATED_PLAN.md` §12.2, **Gap 4a**: "the H-series is single-shot.  The
numerics restart (`evolve_restarted`) … Missing: the restart cycle as a formal
object, the per-restart error accumulation over a long interval."

This chapter supplies exactly that, on the generic machinery: the restarted
scheme is the `n`-fold iterate of a single-cycle approximant, and its error over
`n` cycles grows at most *linearly* in `n` — the classical telescoping estimate
for two contractive propagators.

## Deliverables

* `norm_pow_apply_le_of_contraction` — a contraction stays a contraction under
  iteration.
* `restart_error_accumulation` — **headline**: if the exact one-cycle propagator
  `U` and the restarted approximant `S` are both contractions and
  `‖U w − S w‖ ≤ ε‖w‖` for every state, then after `n` cycles
  `‖Uⁿ v − Sⁿ v‖ ≤ n·ε·‖v‖`.  No commutation between `U` and `S` is used.
* `restart_error_accumulation_sirk` — the SIRK instance: with the per-cycle
  error given by `ChapterH6.sirkBound`, the accumulated error over `n` restarts
  is `n · 2C e^{−hm} Dmin ‖v‖`.
* `restart_error_tendsto_zero` — for a fixed number of cycles the accumulated
  error still decays exponentially in the Krylov dimension, so restarting does
  not destroy the `e^{−hm}` guarantee; it only multiplies it by the cycle count.
* `brst_leakage_bound` — **§12.2 Gap 5**: the truncated dynamics do not preserve
  the physical subspace, and the leakage out of it is bounded by the truncation
  error.  For a BRST charge `Ω` commuting with the exact propagator
  (`ChapterBRSTNilpotent` supplies `Ω² = 0` and `[H, Ω] = 0`) and a physical
  initial state (`Ωv = 0`), the leakage after `n` restart cycles obeys
  `‖Ω Sⁿ v‖ ≤ ‖Ω‖ · n · ε · ‖v‖`.  In particular the exact flow leaks nothing
  (`brst_leakage_zero_of_exact`).

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

noncomputable section

open Filter Topology

namespace BookProof.ChapterSirkRestart

open BookProof.ChapterH6

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

/-- A contraction stays a contraction under iteration. -/
theorem norm_pow_apply_le_of_contraction (S : E →L[ℂ] E) (hS : ∀ w : E, ‖S w‖ ≤ ‖w‖)
    (n : ℕ) (v : E) : ‖(S ^ n) v‖ ≤ ‖v‖ := by
  induction n with
  | zero => simp
  | succ n ih =>
    have hstep : ((S ^ (n + 1)) v) = S ((S ^ n) v) := by
      rw [pow_succ']; rfl
    rw [hstep]
    exact le_trans (hS _) ih

/-- **The accumulated restart error (§12.2 Gap 4a).**  If the exact one-cycle
propagator `U` and the restarted approximant `S` are contractions and differ by
at most `ε` in the strong sense, then over `n` restart cycles the error grows at
most linearly:  `‖Uⁿ v − Sⁿ v‖ ≤ n·ε·‖v‖`. -/
theorem restart_error_accumulation (U S : E →L[ℂ] E) (eps : ℝ)
    (hU : ∀ w : E, ‖U w‖ ≤ ‖w‖) (hS : ∀ w : E, ‖S w‖ ≤ ‖w‖)
    (hstep : ∀ w : E, ‖U w - S w‖ ≤ eps * ‖w‖)
    (n : ℕ) (v : E) :
    ‖(U ^ n) v - (S ^ n) v‖ ≤ n * eps * ‖v‖ := by
  rcases eq_or_ne v 0 with rfl | hv0
  · simp
  have hvpos : 0 < ‖v‖ := norm_pos_iff.mpr hv0
  have heps : 0 ≤ eps := by
    have h0 : (0 : ℝ) ≤ eps * ‖v‖ := le_trans (norm_nonneg _) (hstep v)
    nlinarith
  induction n with
  | zero => simp
  | succ n ih =>
    have hUstep : ((U ^ (n + 1)) v) = U ((U ^ n) v) := by rw [pow_succ']; rfl
    have hSstep : ((S ^ (n + 1)) v) = S ((S ^ n) v) := by rw [pow_succ']; rfl
    have hsplit : U ((U ^ n) v) - S ((S ^ n) v)
        = U ((U ^ n) v - (S ^ n) v) + (U ((S ^ n) v) - S ((S ^ n) v)) := by
      rw [map_sub]; abel
    have h1 : ‖U ((U ^ n) v - (S ^ n) v)‖ ≤ n * eps * ‖v‖ :=
      le_trans (hU _) ih
    have h2 : ‖U ((S ^ n) v) - S ((S ^ n) v)‖ ≤ eps * ‖v‖ := by
      refine le_trans (hstep _) ?_
      exact mul_le_mul_of_nonneg_left
        (norm_pow_apply_le_of_contraction S hS n v) heps
    rw [hUstep, hSstep, hsplit]
    refine le_trans (norm_add_le _ _) ?_
    have : ((n : ℝ) + 1) * eps * ‖v‖ = n * eps * ‖v‖ + eps * ‖v‖ := by ring
    push_cast
    linarith

/-- **The SIRK restart instance.**  With the per-cycle guarantee of
`ChapterH6.sirkBound` (relative to the state norm), the accumulated error over
`n` restart cycles is `n · 2C e^{−hm} Dmin ‖v‖`. -/
theorem restart_error_accumulation_sirk (U S : E →L[ℂ] E) (C Dmin h : ℝ) (m : ℕ)
    (hU : ∀ w : E, ‖U w‖ ≤ ‖w‖) (hS : ∀ w : E, ‖S w‖ ≤ ‖w‖)
    (hstep : ∀ w : E, ‖U w - S w‖ ≤ sirkBound C Dmin h 1 m * ‖w‖)
    (n : ℕ) (v : E) :
    ‖(U ^ n) v - (S ^ n) v‖ ≤ n * sirkBound C Dmin h 1 m * ‖v‖ :=
  restart_error_accumulation U S _ hU hS hstep n v

/-! ## The physical-subspace (BRST) leakage -/

/-- A bounded operator commuting with `U` commutes with all its powers. -/
theorem comp_pow_of_comm (U Om : E →L[ℂ] E) (hcomm : Om.comp U = U.comp Om) (n : ℕ) :
    Om.comp (U ^ n) = (U ^ n).comp Om := by
  induction n with
  | zero => ext w; simp
  | succ n ih =>
    have hpow : (U ^ (n + 1)) = U.comp (U ^ n) := by
      rw [pow_succ']; rfl
    ext w
    have h1 : Om (U ((U ^ n) w)) = U (Om ((U ^ n) w)) :=
      congrArg (fun f : E →L[ℂ] E => f ((U ^ n) w)) hcomm
    have h2 : Om ((U ^ n) w) = (U ^ n) (Om w) :=
      congrArg (fun f : E →L[ℂ] E => f w) ih
    simp only [hpow, ContinuousLinearMap.coe_comp', Function.comp_apply]
    rw [h1, h2]

/-- **The exact flow does not leak.**  A physical state stays physical under a
propagator commuting with the BRST charge. -/
theorem brst_leakage_zero_of_exact (U Om : E →L[ℂ] E)
    (hcomm : Om.comp U = U.comp Om) (n : ℕ) (v : E) (hv : Om v = 0) :
    Om ((U ^ n) v) = 0 := by
  have h : Om ((U ^ n) v) = (U ^ n) (Om v) :=
    congrArg (fun f : E →L[ℂ] E => f v) (comp_pow_of_comm U Om hcomm n)
  rw [h, hv, map_zero]

/-- **The BRST leakage of the truncated dynamics (§12.2 Gap 5).**  The truncated
propagator `S` does not preserve the physical subspace, but the leakage it
produces is controlled by the truncation error: after `n` restart cycles from a
physical state `v`, `‖Ω Sⁿ v‖ ≤ ‖Ω‖ · n · ε · ‖v‖`. -/
theorem brst_leakage_bound (U S Om : E →L[ℂ] E) (eps : ℝ)
    (hU : ∀ w : E, ‖U w‖ ≤ ‖w‖) (hS : ∀ w : E, ‖S w‖ ≤ ‖w‖)
    (hstep : ∀ w : E, ‖U w - S w‖ ≤ eps * ‖w‖)
    (hcomm : Om.comp U = U.comp Om)
    (n : ℕ) (v : E) (hv : Om v = 0) :
    ‖Om ((S ^ n) v)‖ ≤ ‖Om‖ * (n * eps * ‖v‖) := by
  have hexact : Om ((U ^ n) v) = 0 := brst_leakage_zero_of_exact U Om hcomm n v hv
  have hsplit : Om ((S ^ n) v) = -(Om ((U ^ n) v - (S ^ n) v)) := by
    rw [map_sub, hexact]
    abel
  rw [hsplit, norm_neg]
  refine le_trans (Om.le_opNorm _) ?_
  exact mul_le_mul_of_nonneg_left
    (restart_error_accumulation U S eps hU hS hstep n v) (norm_nonneg _)

/-- For a fixed number of restart cycles the accumulated bound still decays
exponentially in the Krylov dimension. -/
theorem restart_error_tendsto_zero (C Dmin h nv : ℝ) (n : ℕ) (hh : 0 < h) :
    Tendsto (fun m : ℕ => (n : ℝ) * sirkBound C Dmin h nv m) atTop (𝓝 0) := by
  have := (sirk_error_decay_exponential C Dmin h nv hh).const_mul (n : ℝ)
  simpa using this

end BookProof.ChapterSirkRestart
