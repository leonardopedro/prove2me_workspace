-- Generated from ChapterNavierStokesFarisLavineLift.lean — solution of BookProof.NavierStokesFlow.FarisLavineLift.ComparisonData.comparison_isSymmetricDom
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FarisLavineLift.ComparisonData











open FullEsa



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]






variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



variable {d : ℕ} (c : ComparisonData F d)

set_option maxHeartbeats 1000000 in
theorem solution : IsSymmetricDom c.comparison := by

  have hid : IsSymmetricDom (LinearMap.id : c.D →ₗ[ℂ] c.D) := by
    intro x y
    simp
  refine IsSymmetricDom.add (IsSymmetricDom.add ?_ ?_) hid
  · exact IsSymmetricDom.sum Finset.univ fun i _ =>
      (c.mom_symm i).comp_of_commute (c.mom_symm i) rfl
  · exact IsSymmetricDom.sum Finset.univ fun i _ =>
      (c.drift_symm i).comp_of_commute (c.drift_symm i) rfl
