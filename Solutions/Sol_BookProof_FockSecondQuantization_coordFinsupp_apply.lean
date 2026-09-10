-- Generated from ChapterFockSecondQuantization.lean — solution of BookProof.FockSecondQuantization.coordFinsupp_apply
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization








open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

















































































variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution {b : HilbertBasis ℕ ℂ F} {x : F} (hx : x ∈ finiteModeDomain b)
    (j : ℕ) : coordFinsupp b x j = inner ℂ (b j) x := by

  classical
  have hx' : x ∈ Submodule.span ℂ (Set.range b) := hx
  have hspec : ((Finsupp.mem_span_range_iff_exists_finsupp.mp hx').choose.sum
      fun i a => a • b i) = x := (Finsupp.mem_span_range_iff_exists_finsupp.mp hx').choose_spec
  rw [coordFinsupp, dif_pos hx]
  conv_rhs => rw [← hspec]
  rw [← Finsupp.linearCombination_apply, b.orthonormal.inner_right_finsupp]
