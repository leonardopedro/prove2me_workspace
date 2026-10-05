-- Generated from ChapterPvmInducedSystem.lean — solution of BookProof.ChapterPvmInducedSystem.cyclicSubspace_le_orthogonal
import Mathlib
import Definitions.Def_ChapterPvmInducedSystem
import Theorems.Thm_BookProof_ChapterPvmCyclicDecomposition_orthOrbit_pairs
open BookProof.ChapterPvmInducedSystem



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure BookProof.ChapterPvmCyclicUnitary
open BookProof.ChapterPvmCyclicDecomposition BookProof.ChapterMackeyQuasiInvariant
open BookProof.ChapterHilbertSumIntertwine

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable {K : Type*} [NormedAddCommGroup K] [InnerProductSpace ℂ K]

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable {K : Type*} [NormedAddCommGroup K] [InnerProductSpace ℂ K]
variable [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution {P : Pvm X H} {ψ φ : H} (h : OrthOrbit P ψ φ) :
    cyclicSubspace P ψ ≤ (cyclicSubspace P φ)ᗮ := by

  refine Submodule.topologicalClosure_minimal _ ?_ (Submodule.isClosed_orthogonal _)
  rw [Submodule.span_le]
  rintro _ ⟨E, hE, rfl⟩
  -- `P(E) ψ` is orthogonal to the whole cyclic subspace of `φ`
  have hstep : cyclicSubspace P φ ≤ (Submodule.span ℂ {P.p E ψ})ᗮ := by
    refine Submodule.topologicalClosure_minimal _ ?_ (Submodule.isClosed_orthogonal _)
    rw [Submodule.span_le]
    rintro _ ⟨F, hF, rfl⟩
    rw [SetLike.mem_coe, Submodule.mem_orthogonal]
    intro w hw
    rw [Submodule.mem_span_singleton] at hw
    obtain ⟨c, rfl⟩ := hw
    rw [inner_smul_left, orthOrbit_pairs h hE hF, mul_zero]
  rw [SetLike.mem_coe, Submodule.mem_orthogonal]
  intro w hw
  have hz := (Submodule.mem_orthogonal _ w).mp (hstep hw) (P.p E ψ)
    (Submodule.mem_span_singleton_self _)
  have hc := congrArg (starRingEnd ℂ) hz
  rwa [inner_conj_symm, map_zero] at hc
