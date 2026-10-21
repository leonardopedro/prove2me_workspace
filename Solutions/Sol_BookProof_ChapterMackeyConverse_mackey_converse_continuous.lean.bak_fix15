-- Generated from ChapterMackeyConverse.lean — solution of BookProof.ChapterMackeyConverse.mackey_converse_continuous
import Mathlib
import Definitions.Def_ChapterMackeyConverse
import Theorems.Thm_BookProof_ChapterMackeyCocycle_covariant_unitary_is_induced
import Theorems.Thm_BookProof_ChapterPvmCyclicUnitary_swCLM_proj
open BookProof.ChapterMackeyConverse



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure BookProof.ChapterMackeyQuasiInvariant
open BookProof.ChapterPvmCyclicUnitary BookProof.ChapterMackeyCocycle

variable {G X H : Type*} [Group G] [MeasurableSpace X] [MulAction G X]
variable [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {G X H : Type*} [Group G] [MeasurableSpace X] [MulAction G X]
variable [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (S : ContinuousImprimitivitySystem G X H) (ψ : H)
    (hcyc : IsCyclic S.P ψ) :
    ∃ (W : Lp ℂ 2 (pvmMeasure S.P ψ) ≃ₗᵢ[ℂ] H) (u : G → X → ℂ),
      QuasiInvariant (pvmMeasure S.P ψ) G ∧
      (∀ g x, ‖u g x‖ = 1) ∧ (∀ g, Measurable (u g)) ∧
      (∀ (E : Set X) (hE : MeasurableSet E) (f : Lp ℂ 2 (pvmMeasure S.P ψ)),
          W (proj (pvmMeasure S.P ψ) hE f) = S.P.p E (W f)) ∧
      (∀ (g : G) (f : Lp ℂ 2 (pvmMeasure S.P ψ)),
          ((W.symm (S.U g (W f))) : X → ℂ) =ᵐ[pvmMeasure S.P ψ]
            fun x => u g x * (sqrtDens (pvmMeasure S.P ψ) g x : ℂ) * (f : X → ℂ) (g⁻¹ • x)) := by

  set μ := pvmMeasure S.P ψ with hμ
  set W := swEquiv S.P ψ hcyc with hW
  -- the unitary `W` carries multiplication by indicators to the projection-valued measure
  have hWproj : ∀ (E : Set X) (hE : MeasurableSet E) (f : Lp ℂ 2 μ),
      W (proj μ hE f) = S.P.p E (W f) := fun _ hE f => swCLM_proj S.P ψ hE f
  -- transport the representation to `L²(X, μ)`
  set V : G → (Lp ℂ 2 μ ≃ₗᵢ[ℂ] Lp ℂ 2 μ) := fun g => W.trans ((S.U g).trans W.symm) with hV
  have key : ∀ (g : G) (v : Lp ℂ 2 μ), W (V g v) = S.U g (W v) := by
    intro g v
    exact W.apply_symm_apply _
  have hcov : Covariant μ S.measurable V := by
    intro g E hE f
    refine W.injective ?_
    rw [key, hWproj, S.covariant g hE, hWproj, key]
  obtain ⟨hqi, u, hu1, humeas, hform⟩ := covariant_unitary_is_induced hcov
  refine ⟨W, u, hqi, hu1, humeas, hWproj, fun g f => ?_⟩
  exact hform g f
