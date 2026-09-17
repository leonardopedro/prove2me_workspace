-- Generated from ChapterH9.lean — solution of BookProof.ChapterH9.coordIncl_norm_map
import Mathlib
import Definitions.Def_ChapterH9
import Theorems.Thm_BookProof_ChapterH9_norm_map_of_adjoint_comp
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
theorem solution {m n : ℕ} (hmn : m ≤ n) (x : EuclideanSpace ℂ (Fin m)) :
    ‖coordIncl hmn x‖ = ‖x‖ := norm_map_of_adjoint_comp (coordIncl_adjoint_comp hmn) x
