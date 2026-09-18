-- Generated from ChapterYangMillsFriedrichs.lean — solution of BookProof.YangMillsFriedrichs.weylKrylov_bestApprox_antitone
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
import Theorems.Thm_BookProof_ChapterH9_krylov_bestApprox_antitone
open BookProof.YangMillsFriedrichs




open BookProof.FarisLavine



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (H : E →ₗ[ℂ] E) (v : E) {p q : ℕ} (hpq : p ≤ q) (u : E) :
    ‖u - (krylovSpan H v q).starProjection u‖ ≤ ‖u - (krylovSpan H v p).starProjection u‖ := krylov_bestApprox_antitone H v hpq u
