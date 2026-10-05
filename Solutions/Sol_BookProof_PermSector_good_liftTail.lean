-- Generated from ChapterPermutationSectorEsa.lean — solution of BookProof.PermSector.good_liftTail
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
open BookProof.PermSector




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ}
    {uD : ((domSpace Hs D₂).pow n).carrier ≃ₗᵢ[ℂ] ((domSpace Hs D₂).pow n).carrier}
    {uH : (Hs.pow n).carrier ≃ₗᵢ[ℂ] (Hs.pow n).carrier} (h : Good Hs D₂ A D n uD uH) :
    Good Hs D₂ A D (n + 1) (liftTail (domSpace Hs D₂) uD) (liftTail Hs uH) where
  incl t :=
  where
    incl t := by
      induction t using TensorProduct.induction_on with
      | zero => simp
      | tmul a b =>
          rw [liftTail_tmul, inclPow_tmul, inclPow_tmul, liftTail_tmul, h.incl]
      | add u v hu hv => simp only [map_add, hu, hv]
    der t := by
      induction t using TensorProduct.induction_on with
      | zero => simp
      | tmul a b =>
          rw [liftTail_tmul, derPow_tmul, derPow_tmul, map_add, liftTail_tmul, liftTail_tmul,
            h.incl, h.der]
      | add u v hu hv => simp only [map_add, hu, hv]
    core t ht := by
      induction ht using Submodule.span_induction with
      | mem u hu =>
          obtain ⟨a, haD, b, hb, rfl⟩ := hu
          rw [liftTail_tmul]
          exact tmul_mem_corePow Hs D₂ D haD (h.core b hb)
      | zero => simp
      | add u v _ _ hu hv => rw [map_add]; exact Submodule.add_mem _ hu hv
      | smul r u _ hu => rw [map_smul]; exact Submodule.smul_mem _ r hu
