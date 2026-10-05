-- Generated from ChapterPermutationSectorEsa.lean — solution of BookProof.PermSector.good_swapFirst
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
import Theorems.Thm_BookProof_PermSector_tensor_triple_induction
open BookProof.PermSector




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) :
    Good Hs D₂ A D (n + 2) (swapFirst (domSpace Hs D₂) n) (swapFirst Hs n) where
  incl t :=
  where
    incl t := by
      refine tensor_triple_induction (X := D₂) (Y := D₂)
        (Z := ((domSpace Hs D₂).pow n).carrier)
        (P := fun t => inclPow Hs D₂ (n + 2) (swapFirst (domSpace Hs D₂) n t)
          = swapFirst Hs n (inclPow Hs D₂ (n + 2) t)) ?_ ?_ ?_ t
      · simp
      · intro a b r
        rw [swapFirst_tmul, inclPow_tmul, inclPow_tmul, inclPow_tmul, inclPow_tmul,
          swapFirst_tmul]
      · intro u v hu hv
        simp only [map_add, hu, hv]
    der t := by
      refine tensor_triple_induction (X := D₂) (Y := D₂)
        (Z := ((domSpace Hs D₂).pow n).carrier)
        (P := fun t => derPow Hs D₂ A (n + 2) (swapFirst (domSpace Hs D₂) n t)
          = swapFirst Hs n (derPow Hs D₂ A (n + 2) t)) ?_ ?_ ?_ t
      · simp
      · intro a b r
        rw [swapFirst_tmul, derPow_tmul, derPow_tmul, derPow_tmul, derPow_tmul, inclPow_tmul,
          inclPow_tmul, TensorProduct.tmul_add, TensorProduct.tmul_add, map_add, map_add,
          swapFirst_tmul, swapFirst_tmul, swapFirst_tmul]
        abel
      · intro u v hu hv
        simp only [map_add, hu, hv]
    core t ht := by
      induction ht using Submodule.span_induction with
      | mem u hu =>
          obtain ⟨a, haD, b, hb, rfl⟩ := hu
          induction hb using Submodule.span_induction with
          | mem v hv =>
              obtain ⟨b', hb'D, r, hr, rfl⟩ := hv
              rw [swapFirst_tmul]
              exact tmul_mem_corePow Hs D₂ D hb'D (tmul_mem_corePow Hs D₂ D haD hr)
          | zero => simp
          | add s s' _ _ hs hs' =>
              rw [TensorProduct.tmul_add, map_add]
              exact Submodule.add_mem _ hs hs'
          | smul r s _ hs =>
              rw [TensorProduct.tmul_smul, map_smul]
              exact Submodule.smul_mem _ r hs
      | zero => simp
      | add u v _ _ hu hv => rw [map_add]; exact Submodule.add_mem _ hu hv
      | smul r u _ hu => rw [map_smul]; exact Submodule.smul_mem _ r hu
