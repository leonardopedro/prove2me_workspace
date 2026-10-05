-- Generated from ChapterQgBrstCompleted.lean — solution of BookProof.QgBrstCompleted.qgPhaseFull_isometry
import Mathlib
import Definitions.Def_ChapterQgBrstCompleted
import Theorems.Thm_BookProof_QgBrstCompleted_wshift_norm_eq
open BookProof.QgBrstCompleted




open scoped ENNReal
open BookProof BookProof.QuantumGravityFock BookProof.BrstReducedTransfer

noncomputable section

variable {ι : Type*}
variable (w : ι → ℂ) (e : ι → ι) (hw : ∀ i, ‖w i‖ ≤ 1) (hinj : Set.InjOn e {i | w i ≠ 0})

set_option maxHeartbeats 1000000 in
theorem solution (omega g : ℕ → ℝ) (t : ℝ) (f : QGH) :
    ‖qgPhaseFull omega g t f‖ = ‖f‖ := wshift_norm_eq _ _ _ _ (fullPhaseWeight_norm omega g t) rfl f
