-- Generated from ChapterPvmScalarMeasure.lean — solution of BookProof.ChapterPvmScalarMeasure.p_eq_zero_of_forall_measure_zero
import Mathlib
import Definitions.Def_ChapterPvmScalarMeasure
import Theorems.Thm_BookProof_ChapterPvmMeasure_pvmMeasure_eq_zero_iff
open BookProof.ChapterPvmScalarMeasure



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure BookProof.ChapterPvmCyclicDecomposition
open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterMackeyConverse
open BookProof.ChapterPvmInducedSystem

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

set_option maxHeartbeats 1000000 in
theorem solution {P : Pvm X H} {S : Set H}
    (hdense : Dense ((Submodule.span ℂ (familyOrbit P S) : Submodule ℂ H) : Set H))
    {E : Set X} (hE : MeasurableSet E) (h : ∀ ψ ∈ S, pvmMeasure P ψ E = 0) :
    P.p E = 0 := by

  have hgen : ∀ v ∈ familyOrbit P S, P.p E v = 0 := by
    intro v hv
    obtain ⟨ψ, hψ, F, hF, rfl⟩ := Set.mem_iUnion₂.mp hv
    have hEF : pvmMeasure P ψ (E ∩ F) = 0 :=
      measure_mono_null Set.inter_subset_left (h ψ hψ)
    have hzero := (pvmMeasure_eq_zero_iff P ψ (hE.inter hF)).mp hEF
    rw [P.inter hE hF ψ]
    exact hzero
  have hspan : ∀ v ∈ (Submodule.span ℂ (familyOrbit P S) : Submodule ℂ H), P.p E v = 0 := by
    intro v hv
    induction hv using Submodule.span_induction with
    | mem x hx => exact hgen x hx
    | zero => simp
    | add x y _ _ hx hy => simp [map_add, hx, hy]
    | smul c x _ hx => simp [map_smul, hx]
  have hclosed : IsClosed {v : H | P.p E v = 0} := isClosed_eq (P.p E).continuous continuous_const
  ext v
  have hv : v ∈ closure ((Submodule.span ℂ (familyOrbit P S) : Submodule ℂ H) : Set H) :=
    hdense v
  have := (closure_minimal (fun w hw => hspan w hw) hclosed) hv
  exact this
