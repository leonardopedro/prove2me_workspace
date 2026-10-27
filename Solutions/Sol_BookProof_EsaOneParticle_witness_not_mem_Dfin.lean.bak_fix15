-- Generated from ChapterEsaOneParticleDGamma.lean — solution of BookProof.EsaOneParticle.witness_not_mem_Dfin
import Mathlib
import Definitions.Def_ChapterEsaOneParticleDGamma
import Theorems.Thm_BookProof_EsaOneParticle_Dfin_le_finSupp
open BookProof.EsaOneParticle




open scoped TensorProduct ENNReal
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A₂ : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier) (hle : D ≤ D₂)
  (hext : ∀ v : D, A₂ ⟨(v : Hs.carrier), hle v.2⟩ = A v)
variable {Hs : IPSpace} {D : Submodule ℂ Hs.carrier}
variable [CompleteSpace Hs.carrier]
variable {Hs : IPSpace} [CompleteSpace Hs.carrier] {D : Submodule ℂ Hs.carrier}
  (A : D →ₗ[ℂ] Hs.carrier) (hdense : Dense (D : Set Hs.carrier)) (hsym : SymmetricOn D A)
  (hesa : EssentiallySelfAdjointOn D A)
variable {Hs : IPSpace}

set_option maxHeartbeats 1000000 in
theorem solution : witness ∉ Dfin := by

  intro hmem
  have hfin : {k : ℤ | (witness : ℤ → ℂ) k ≠ 0}.Finite := Dfin_le_finSupp hmem
  have huniv : {k : ℤ | (witness : ℤ → ℂ) k ≠ 0} = Set.univ := by
    ext k
    have hpos : (0 : ℝ) < 1 / ((k : ℝ) ^ 2 + 1) := by positivity
    simp only [Set.mem_setOf_eq, Set.mem_univ, iff_true, witness_apply, witnessFun, ne_eq,
      Complex.ofReal_eq_zero]
    exact ne_of_gt hpos
  rw [huniv] at hfin
  exact Set.infinite_univ hfin
