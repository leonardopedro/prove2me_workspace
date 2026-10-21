-- Generated from ChapterQgBrstCompleted.lean — solution of BookProof.QgBrstCompleted.qgPhaseFull_not_comm_brst
import Mathlib
import Definitions.Def_ChapterQgBrstCompleted
import Theorems.Thm_BookProof_QgBrstCompleted_oneSym_norm_le
import Theorems.Thm_BookProof_QgBrstCompleted_qgBrstCharge_one_ghost_zero
import Theorems.Thm_BookProof_QuantumGravityFock_qgGradedSymbol_oneGhost
open BookProof.QgBrstCompleted




open scoped ENNReal
open BookProof BookProof.QuantumGravityFock BookProof.BrstReducedTransfer

noncomputable section

variable {ι : Type*}
variable (w : ι → ℂ) (e : ι → ι) (hw : ∀ i, ‖w i‖ ≤ 1) (hinj : Set.InjOn e {i | w i ≠ 0})

set_option maxHeartbeats 1000000 in
theorem solution (omega g : ℕ → ℝ) (hg : g 0 ≠ 0) :
    ¬ ∀ (t : ℝ) (y : QGH), qgPhaseFull omega g t (qgBrstCharge oneSym oneSym_norm_le y)
      = qgBrstCharge oneSym oneSym_norm_le (qgPhaseFull omega g t y) := by

  classical
  intro hcomm
  set t : ℝ := Real.pi / g 0 with ht
  set f : QGH := lp.single 2 ((0 : BoseConf), (∅ : FermConf)) 1 with hf
  have hfv : f ((0 : BoseConf), (∅ : FermConf)) = 1 := by
    rw [hf]; simp
  have h := congrArg (fun z : QGH => z ((0 : BoseConf), ({0} : FermConf))) (hcomm t f)
  simp only [qgPhaseFull_apply, qgBrstCharge_one_ghost_zero] at h
  rw [hfv, mul_one] at h
  -- the vacuum has zero energy, the one-ghost state has energy `g 0`
  have hg0 : ((g 0 : ℝ) : ℂ) ≠ 0 := by exact_mod_cast hg
  have hpi : ((t : ℂ) * ((g 0 : ℝ) : ℂ)) = ((Real.pi : ℝ) : ℂ) := by
    rw [ht]
    push_cast
    field_simp
  rw [fullPhaseWeight, fullPhaseWeight, qgGradedSymbol_oneGhost, qgGradedSymbol_vacuum,
    hpi] at h
  rw [show (-((Real.pi : ℝ) : ℂ)) * Complex.I = -(((Real.pi : ℝ) : ℂ) * Complex.I) by ring,
    Complex.exp_neg, Complex.exp_pi_mul_I] at h
  norm_num at h
