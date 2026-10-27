-- Generated from ChapterPvmFibreInducedSystem.lean — solution of BookProof.ChapterPvmFibreInducedSystem.induced_system_of_isHilbertSum
import Mathlib
import Definitions.Def_ChapterPvmFibreInducedSystem
import Theorems.Thm_BookProof_ChapterHilbertSumIntertwine_linearIsometryEquiv_intertwine
import Theorems.Thm_BookProof_ChapterL2FibreSum_fibreEquiv_proj
open BookProof.ChapterPvmFibreInducedSystem



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure BookProof.ChapterPvmCyclicUnitary
open BookProof.ChapterPvmCyclicDecomposition BookProof.ChapterPvmInducedSystem
open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterL2FibreSum
open BookProof.ChapterHilbertSumIntertwine

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution {ι : Type*} [Countable ι]
    (P : Pvm X H) (μ : Measure X) (V : ∀ _ : ι, Lp ℂ 2 μ →ₗᵢ[ℂ] H)
    (hsum : IsHilbertSum ℂ (fun _ : ι => Lp ℂ 2 μ) V)
    (hint : ∀ (i : ι) (E : Set X) (hE : MeasurableSet E) (f : Lp ℂ 2 μ),
      V i (proj μ hE f) = P.p E (V i f)) :
    ∃ W : H ≃ₗᵢ[ℂ] Lp (Fibre ι) 2 μ,
      ∀ (E : Set X) (hE : MeasurableSet E) (v : H), W (P.p E v) = proj μ hE (W v) := by

  classical
  refine ⟨hsum.linearIsometryEquiv.trans (fibreEquiv (ι := ι) μ).symm, ?_⟩
  intro E hE v
  set U := hsum.linearIsometryEquiv with hU
  set F := fibreEquiv (ι := ι) μ with hF
  -- both sides have the same image under the unitary `F`
  have hgoal : F (F.symm (U (P.p E v))) = F (proj μ hE (F.symm (U v))) := by
    rw [LinearIsometryEquiv.apply_symm_apply]
    refine lp.ext ?_
    funext i
    have hleft : U (P.p E v) i = proj μ hE (U v i) :=
      linearIsometryEquiv_intertwine hsum (P.p E) (fun _ : ι => projCLM μ hE)
        (fun _ u => ChapterL2FibreSum.norm_proj_le μ hE u) (fun i u => hint i E hE u) v i
    have hright : F (proj μ hE (F.symm (U v))) i = proj μ hE (F (F.symm (U v)) i) :=
      fibreEquiv_proj μ hE (F.symm (U v)) i
    rw [hleft, hright, LinearIsometryEquiv.apply_symm_apply]
  have := congrArg F.symm hgoal
  rw [LinearIsometryEquiv.symm_apply_apply, LinearIsometryEquiv.symm_apply_apply] at this
  exact this
