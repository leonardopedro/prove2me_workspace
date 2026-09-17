-- Generated from ChapterH9.lean — solution of BookProof.ChapterH9.norm_map_of_adjoint_comp
import Mathlib
import Definitions.Def_ChapterH9
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
theorem solution {V : F →L[ℂ] E}
    (hV : (adjoint V).comp V = ContinuousLinearMap.id ℂ F) (x : F) : ‖V x‖ = ‖x‖ := by

  have hx : (adjoint V) (V x) = x := congrArg (fun f : F →L[ℂ] F => f x) hV
  have h : (inner ℂ (V x) (V x) : ℂ) = inner ℂ x x := by
    rw [← adjoint_inner_left V x (V x), hx]
  have h2 := congrArg (RCLike.re (K := ℂ)) h
  rw [inner_self_eq_norm_sq (V x), inner_self_eq_norm_sq x] at h2
  nlinarith [norm_nonneg (V x), norm_nonneg x]
