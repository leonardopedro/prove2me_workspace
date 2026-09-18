import Definitions.Def_ChapterH1
import Definitions.Def_ChapterH4
import Definitions.Def_ChapterH5
import Definitions.Def_ChapterH6
import Definitions.Def_ChapterH8
-- Generated from ChapterH9.lean — solution of BookProof.ChapterH9.krylov_bestApprox_tendsto_zero
import Mathlib
import Definitions.Def_ChapterH9
import Theorems.Thm_BookProof_ChapterH9_norm_sub_starProjection_le
open BookProof.ChapterH9



noncomputable section


open BookProof.ChapterH1 BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6
open BookProof.ChapterH8
open ContinuousLinearMap


variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

set_option maxHeartbeats 1000000 in
theorem solution (H : E →ₗ[ℂ] E) (v u : E)
    (hdense : Dense ((⨆ n : ℕ, krylovSpan H v n : Submodule ℂ E) : Set E)) :
    Filter.Tendsto (fun n : ℕ => ‖u - (krylovSpan H v n).starProjection u‖)
      Filter.atTop (nhds 0) := by

  rw [Metric.tendsto_atTop]
  intro eps heps
  obtain ⟨w, hw, hwd⟩ := hdense.exists_dist_lt u heps
  have hmono : Monotone (fun n : ℕ => krylovSpan H v n) := fun _ _ hab => krylovSpan_mono hab
  have hdir : Directed (fun x1 x2 : Submodule ℂ E => x1 ≤ x2) (fun n : ℕ => krylovSpan H v n) :=
    hmono.directed_le
  obtain ⟨N, hN⟩ := (Submodule.mem_iSup_of_directed _ hdir).mp hw
  refine ⟨N, fun n hn => ?_⟩
  have h1 : ‖u - (krylovSpan H v n).starProjection u‖ ≤ ‖u - w‖ :=
    norm_sub_starProjection_le _ u w (krylovSpan_mono hn hN)
  have h2 : ‖u - w‖ < eps := by simpa [dist_eq_norm] using hwd
  have h3 : dist ‖u - (krylovSpan H v n).starProjection u‖ 0
      = ‖u - (krylovSpan H v n).starProjection u‖ := by
    simp
  rw [h3]
  exact lt_of_le_of_lt h1 h2
