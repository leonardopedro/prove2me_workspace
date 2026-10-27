-- Generated from PhysFunctionalAnalysis.lean — solution of PhysFunctionalAnalysis.exists_l2_iso
import Mathlib
import Definitions.Def_PhysFunctionalAnalysis
import Theorems.Thm_PhysFunctionalAnalysis_countable_of_separated
open PhysFunctionalAnalysis



open MeasureTheory Set
open scoped ENNReal lp

noncomputable section


open PhysMeasureBasis

set_option maxHeartbeats 1000000 in
theorem solution (E : Type*)
    [NormedAddCommGroup E] [InnerProductSpace ℝ E] [CompleteSpace E]
    [TopologicalSpace.SeparableSpace E] (hE : ¬ FiniteDimensional ℝ E) :
    Nonempty (E ≃ₗᵢ[ℝ] ℓ²(ℕ, ℝ)) := by

  have := exists_hilbertBasis ℝ E;
  obtain ⟨ w, b, hb ⟩ := this;
  -- Since $w$ is countable and infinite, there exists an equivalence $e : ℕ ≃ w$.
  obtain ⟨e, he⟩ : ∃ e : ℕ ≃ w, True := by
    have h_countable : Countable w := by
      convert countable_of_separated ( fun i => b i )
        ( show 0 < ( 1 : ℝ ) / 2 by norm_num ) _ using 1;
      intro i j hij
      have h_dist : ‖b i - b j‖ ^ 2 = 2 := by
        rw [ @norm_sub_sq ℝ ] ; simp +decide [ b.orthonormal.1, b.orthonormal.2 hij ] ; ring;
      rw [ dist_eq_norm ] ; nlinarith [ norm_nonneg ( b i - b j ) ];
    have h_infinite : Infinite w := by
      contrapose! hE;
      convert Module.Basis.finiteDimensional_of_finite ( b.toOrthonormalBasis.toBasis );
      exact Fintype.ofFinite _;
    exact ⟨ ( Classical.arbitrary _ ), trivial ⟩;
  refine ⟨ ?_ ⟩;
  exact ( HilbertBasis.mk ( b.orthonormal.comp _ e.injective ) ( by
    have := b.dense_span;
    simp_all +decide [ Set.range_comp ] ) ).repr
