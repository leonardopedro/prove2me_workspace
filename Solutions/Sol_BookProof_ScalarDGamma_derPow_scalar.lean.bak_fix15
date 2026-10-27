-- Generated from ChapterScalarDGammaEsa.lean — solution of BookProof.ScalarDGamma.derPow_scalar
import Mathlib
import Definitions.Def_ChapterScalarDGammaEsa
import Theorems.Thm_BookProof_ScalarDGamma_scalarOp_apply
open BookProof.ScalarDGamma




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable (Hs : IPSpace) (c : ℝ)

variable (Hs : IPSpace) (c : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (x : ((domSpace Hs ⊤).pow n)) :
    derPow Hs ⊤ (scalarOp Hs c) n x = ((n : ℂ) * c) • inclPow Hs ⊤ n x := by

  induction n with
  | zero => simp [derPow]
  | succ n ih =>
      have hx : x ∈ Submodule.span ℂ
          {t : ((⊤ : Submodule ℂ Hs.carrier) ⊗[ℂ] ((domSpace Hs ⊤).pow n).carrier) |
            ∃ (p : (⊤ : Submodule ℂ Hs.carrier)) (q : ((domSpace Hs ⊤).pow n)),
              p ⊗ₜ[ℂ] q = t} := by
        rw [TensorProduct.span_tmul_eq_top]; trivial
      induction hx using Submodule.span_induction with
      | mem t ht =>
          obtain ⟨a, b, rfl⟩ := ht
          rw [derPow_tmul, inclPow_tmul, ih b, scalarOp_apply, TensorProduct.tmul_smul,
            TensorProduct.smul_tmul', TensorProduct.smul_tmul', ← TensorProduct.add_tmul,
            ← add_smul]
          have hcoef : (c : ℂ) + (n : ℂ) * c = ((n + 1 : ℕ) : ℂ) * c := by push_cast; ring
          rw [hcoef]
      | zero => simp
      | add s t _ _ hs ht => rw [map_add, map_add, hs, ht, smul_add]
      | smul r s _ hs => rw [map_smul, map_smul, hs, smul_comm]
