-- Generated from ChapterQgBrstCompleted.lean — solution of BookProof.QgBrstCompleted.qgPhase_single
import Mathlib
import Definitions.Def_ChapterQgBrstCompleted
open BookProof.QgBrstCompleted




open scoped ENNReal
open BookProof BookProof.QuantumGravityFock BookProof.BrstReducedTransfer

noncomputable section

variable {ι : Type*}
variable (w : ι → ℂ) (e : ι → ι) (hw : ∀ i, ‖w i‖ ≤ 1) (hinj : Set.InjOn e {i | w i ≠ 0})

set_option maxHeartbeats 1000000 in
theorem solution (omega : ℕ → ℝ) (t : ℝ) (p : GradedIdx) (c : ℂ) :
    qgPhase omega t (lp.single 2 p c)
      = Complex.exp (-(t * qgGradedSymbol omega (fun _ => 0) p) * Complex.I) •
          lp.single 2 p c := by

  classical
  ext q
  rw [qgPhase_apply, lp.coeFn_smul, Pi.smul_apply, smul_eq_mul]
  by_cases hq : q = p
  · subst hq
    rw [phaseWeight]
    congr 3
    rw [qgGradedSymbol]
    simp [ghostEnergy]
  · simp [lp.single_apply, hq]
