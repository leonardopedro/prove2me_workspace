-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.resolvent_ladder_lower
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Theorems.Thm_BookProof_ResolventLadder_le_graphRayleighSup
open BookProof.ResolventLadder



noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) (k : ℕ)
    (hne : (graphMinmaxSet T k).Nonempty) :
    1 / maxminLevel (res hT) k - 1 ≤ graphMinmaxLevel T k := by

  refine le_csInf hne ?_
  rintro t ⟨S, hrank, hdom, rfl⟩
  exact le_graphRayleighSup hT hsv hrank hdom
