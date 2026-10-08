-- Generated from ChapterLinftyMultiplication.lean — theorem BookProof.ChapterLinftyMultiplication.vonNeumann_abelian_class_Linfty
import Mathlib
import Definitions.Def_ChapterLinftyMultiplication
import Theorems.Thm_BookProof_ChapterLinftyMultiplication_memLp_top_one
open BookProof.ChapterLinftyMultiplication


noncomputable section

open MeasureTheory ENNReal Complex


variable {α : Type*} [MeasurableSpace α] {μ : Measure α}


theorem BookProof.ChapterLinftyMultiplication.vonNeumann_abelian_class_Linfty [IsFiniteMeasure μ] :
    (multOp (fun _ : α => (1 : ℂ)) memLp_top_one = ContinuousLinearMap.id ℂ (Lp ℂ 2 μ)) ∧
    (∀ (φ ψ : α → ℂ) (hφ : MemLp φ ⊤ μ) (hψ : MemLp ψ ⊤ μ),
      (multOp φ hφ).comp (multOp ψ hψ) = (multOp ψ hψ).comp (multOp φ hφ)) ∧
    (∀ (φ ψ : α → ℂ) (hφ : MemLp φ ⊤ μ) (hψ : MemLp ψ ⊤ μ),
      (multOp φ hφ).comp (multOp ψ hψ)
        = multOp (fun x => φ x * ψ x) (memLp_top_mul hφ hψ)) ∧
    (∀ (φ : α → ℂ) (hφ : MemLp φ ⊤ μ) (f g : Lp ℂ 2 μ),
      inner ℂ (multOp φ hφ f) g
        = inner ℂ f (multOp (fun x => (starRingEnd ℂ) (φ x)) (memLp_top_conj hφ) g)) ∧
    (∀ (φ : α → ℂ) (hφ : MemLp φ ⊤ μ), multOp φ hφ = 0 ↔ φ =ᵐ[μ] 0) := by sorry
