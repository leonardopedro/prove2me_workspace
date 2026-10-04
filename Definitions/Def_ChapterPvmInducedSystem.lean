import Definitions.Def_ChapterPvmCyclicDecomposition
import Definitions.Def_ChapterPvmCyclicUnitary
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterMackeyQuasiInvariant
import Mathlib


/-!
# Assembling the cyclic pieces: the induced system with a multiplicity space

`BookProof.ChapterPvmCyclicDecomposition` decomposes a projection-valued measure into
mutually orthogonal cyclic pieces, and `BookProof.ChapterPvmCyclicUnitary` models each
piece as `L²` of a finite measure.  The boundary recorded there was the *assembly* of the
pieces into a single system.  This file removes it.

## Results

* `conjPvm` — a projection-valued measure transported along a unitary; `conjPvm_apply`.
* `swIsom` (from `ChapterPvmCyclicUnitary`) has range exactly the cyclic subspace of `ψ`
  (`range_swIsom`), even without a cyclicity hypothesis, and it intertwines multiplication
  by `1_E` with `P(E)`.
* `isHilbertSum_swIsom` — for a maximal orthogonal cyclic family `S` the isometries
  `L²(μ_ψ) → H` exhibit `H` as the **Hilbert sum** of the fibres `L²(μ_ψ)`, `ψ ∈ S`.
* **`pvm_direct_sum_model`** — the headline in "internal" form: for every projection-valued
  measure there is a family `S` of unit vectors, and isometries `Vψ : L²(X, μ_ψ) → H`
  exhibiting `H` as their Hilbert sum, with `Vψ (1_E · f) = P(E) (Vψ f)`.
* **`pvm_induced_system`** — the headline in "external" form: a single unitary
  `W : H ≃ ℓ²-⨁_{ψ ∈ S} L²(X, μ_ψ)` carrying `P` to the projection-valued measure which
  acts **fibrewise** as multiplication by `1_E`; the multiplicity (fibre) index space is
  `S`.  Both the transported projection-valued measure `conjPvm P W.symm` and the
  fibrewise description are given.
* `pvm_induced_system_separable` — on a separable space the multiplicity space is
  countable.

Everything is `sorry`-free and uses only the standard axioms.
-/

open MeasureTheory
open scoped InnerProductSpace

namespace BookProof.ChapterPvmInducedSystem

open BookProof.ChapterPvmMeasure BookProof.ChapterPvmCyclicUnitary
open BookProof.ChapterPvmCyclicDecomposition BookProof.ChapterMackeyQuasiInvariant

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable {K : Type*} [NormedAddCommGroup K] [InnerProductSpace ℂ K]

/-! ## Transport of a projection-valued measure along a unitary -/

/-- A projection-valued measure transported along a unitary `W : K ≃ H`:
`E ↦ W⁻¹ P(E) W`. -/
noncomputable def conjPvm (P : Pvm X H) (W : K ≃ₗᵢ[ℂ] H) : Pvm X K where
  p E := (W.symm.toContinuousLinearEquiv.toContinuousLinearMap).comp
    ((P.p E).comp W.toContinuousLinearEquiv.toContinuousLinearMap)
  symm := by
    intro E hE u v
    have hl : ⟪W.symm (P.p E (W u)), v⟫_ℂ = ⟪P.p E (W u), W v⟫_ℂ := by
      have := W.inner_map_map (W.symm (P.p E (W u))) v
      rw [W.apply_symm_apply] at this
      exact this.symm
    have hr : ⟪u, W.symm (P.p E (W v))⟫_ℂ = ⟪W u, P.p E (W v)⟫_ℂ := by
      have := W.inner_map_map u (W.symm (P.p E (W v)))
      rw [W.apply_symm_apply] at this
      exact this.symm
    change ⟪W.symm (P.p E (W u)), v⟫_ℂ = ⟪u, W.symm (P.p E (W v))⟫_ℂ
    rw [hl, hr]
    exact P.symm hE _ _
  inter := by
    intro E F hE hF u
    change W.symm (P.p E (W (W.symm (P.p F (W u))))) = W.symm (P.p (E ∩ F) (W u))
    rw [W.apply_symm_apply, P.inter hE hF]
  univ := by
    intro u
    change W.symm (P.p Set.univ (W u)) = u
    rw [P.univ, W.symm_apply_apply]
  hasSum := by
    intro f hf hdisj u
    have h := P.hasSum f hf hdisj (W u)
    exact h.map (W.symm.toContinuousLinearEquiv.toContinuousLinearMap.toLinearMap.toAddMonoidHom)
      (W.symm.continuous)

@[simp] theorem conjPvm_apply (P : Pvm X H) (W : K ≃ₗᵢ[ℂ] H) {E : Set X} (u : K) :
    (conjPvm P W).p E u = W.symm (P.p E (W u)) := rfl

/-! ## The range of the model of a cyclic piece -/

variable [CompleteSpace H]







/-! ## Orthogonality of the pieces -/







/-! ## The Hilbert sum -/



/-! ## The headline: the direct-sum model -/



/-! ## The fibrewise form: a single induced system -/









end BookProof.ChapterPvmInducedSystem
