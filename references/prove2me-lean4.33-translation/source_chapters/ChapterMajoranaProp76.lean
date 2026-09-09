import Mathlib

/-!
# Chapter "Real representations, CPT theorem and the relativistic position operator",
§"Fourier-Majorana Transform", **Proposition 76** — the energy transform `𝓔` and the
energy–momentum transform `𝓔 ∘ 𝓕_M` are unitary

`book.tex` **Proposition 76** introduces the **energy transform**

  `𝓔 := Θ_{L²} ∘ 𝓕_P(−p⁰) ∘ Θ_{L²}⁻¹`

— the Pauli–Fourier transform `𝓕_P` in the *time* coordinate, conjugated by the
real-linear identification `Θ_{L²}` — and states that `𝓔` is **unitary**, "for the
same conjugation reason" as Proposition 73: a conjugate of a unitary by an
inner-product-preserving bijection is again unitary.  The composite
`𝓔 ∘ 𝓕_M` (with the Majorana–Fourier transform `𝓕_M`) is then the unitary
**energy–momentum transform**.

The book's proof is purely structural:

* the Pauli–Fourier transform `𝓕_P` is unitary on `L²` (Plancherel — Mathlib's
  `MeasureTheory.Lp.fourierTransformₗᵢ`, a genuine `≃ₗᵢ[ℂ]`);
* conjugating a unitary by a linear isometry equivalence `Θ` yields a unitary
  (`𝓔` is unitary);
* composing two unitaries yields a unitary (`𝓔 ∘ 𝓕_M` is unitary).

This file formalizes exactly that structural core, using **Note 4**'s definition
of unitarity (surjective and diagonal-inner-preserving, `⟪f x, f x⟫ = ⟪x, x⟫`),
as already used for Proposition 5.  Working with the bare-function predicate
`IsNote4Unitary` keeps the two closure lemmas (`note4_comp`, `note4_conj`)
maximally general: they need no linearity of the unitary being conjugated, only
that the conjugator `Θ` preserves inner products and is bijective.  We then
instantiate on the concrete Mathlib `L²`-Fourier transform to exhibit the actual
`𝓕_P` as a Note-4 unitary and to build the concrete energy transform `𝓔`.

The `𝓔 ∘ 𝓗_M` "spherical" energy–momentum transform of Proposition 76 involves
the Majorana–Hankel transform `𝓗_M` and is **deliberately not formalized** (off
the Hankel line); the linear `𝓔 ∘ 𝓕_M` branch is what we discharge here.  This
also stays **off the gravity line**.

Everything is `sorry`-free and `axiom`-free.
-/

open scoped InnerProductSpace

namespace BookProof.ChapterMajoranaProp76

variable {𝕜 : Type*} [RCLike 𝕜]

/-- **Note 4 unitarity** for a bare function `f : H → K` between inner-product
spaces: `f` is surjective and preserves the diagonal inner product
`⟪f x, f x⟫ = ⟪x, x⟫`.  (For a linear `f`, polarization upgrades this to full
inner-product preservation; the book states and uses the diagonal form.) -/
def IsNote4Unitary (𝕜 : Type*) [RCLike 𝕜] {H K : Type*}
    [NormedAddCommGroup H] [InnerProductSpace 𝕜 H]
    [NormedAddCommGroup K] [InnerProductSpace 𝕜 K] (f : H → K) : Prop :=
  Function.Surjective f ∧ ∀ x, (inner 𝕜 (f x) (f x) : 𝕜) = (inner 𝕜 x x : 𝕜)

section
variable {H K L : Type*}
  [NormedAddCommGroup H] [InnerProductSpace 𝕜 H]
  [NormedAddCommGroup K] [InnerProductSpace 𝕜 K]
  [NormedAddCommGroup L] [InnerProductSpace 𝕜 L]

/-- **A linear isometry equivalence is a Note-4 unitary.**  It is bijective (hence
surjective) and preserves inner products, in particular the diagonal ones. -/
theorem LinearIsometryEquiv.isNote4Unitary (e : H ≃ₗᵢ[𝕜] K) :
    IsNote4Unitary 𝕜 (e : H → K) :=
  ⟨e.surjective, fun x => e.inner_map_map x x⟩

/-- **Composition of Note-4 unitaries is a Note-4 unitary.**  Surjectivity
composes, and the diagonal-inner-preservation chains
`⟪g (f x), g (f x)⟫ = ⟪f x, f x⟫ = ⟪x, x⟫`. -/
theorem note4_comp {f : H → K} {g : K → L}
    (hf : IsNote4Unitary 𝕜 f) (hg : IsNote4Unitary 𝕜 g) :
    IsNote4Unitary 𝕜 (g ∘ f) :=
  ⟨hg.1.comp hf.1, fun x => by
    simp only [Function.comp_apply]
    rw [hg.2 (f x), hf.2 x]⟩

/-- **Conjugation preserves Note-4 unitarity.**  If `V : H → H` is a Note-4
unitary and `Θ : H ≃ₗᵢ[𝕜] K` is a linear isometry equivalence, then the conjugate
`Θ ∘ V ∘ Θ⁻¹ : K → K` is a Note-4 unitary.  This is Proposition 76's "same
conjugation reason": it is a composition of the unitaries `Θ⁻¹`, `V`, `Θ`. -/
theorem note4_conj (Θ : H ≃ₗᵢ[𝕜] K) {V : H → H} (hV : IsNote4Unitary 𝕜 V) :
    IsNote4Unitary 𝕜 ((Θ : H → K) ∘ V ∘ (Θ.symm : K → H)) := by
  have hΘ : IsNote4Unitary 𝕜 (Θ : H → K) := LinearIsometryEquiv.isNote4Unitary Θ
  have hΘs : IsNote4Unitary 𝕜 (Θ.symm : K → H) :=
    LinearIsometryEquiv.isNote4Unitary Θ.symm
  have h1 : IsNote4Unitary 𝕜 (V ∘ (Θ.symm : K → H)) := note4_comp hΘs hV
  simpa [Function.comp_assoc] using note4_comp h1 hΘ

end

/-! ## The energy transform `𝓔 = Θ ∘ V ∘ Θ⁻¹` and the composite `𝓔 ∘ 𝓕_M` -/

section
variable {H K : Type*}
  [NormedAddCommGroup H] [InnerProductSpace 𝕜 H]
  [NormedAddCommGroup K] [InnerProductSpace 𝕜 K]

/-- The **energy transform** `𝓔 = Θ ∘ V ∘ Θ⁻¹`, the conjugate of the time-Fourier
transform `V = 𝓕_P(−p⁰)` by the real-linear identification `Θ = Θ_{L²}`. -/
def energyTransform (Θ : H ≃ₗᵢ[𝕜] K) (V : H → H) : K → K :=
  (Θ : H → K) ∘ V ∘ (Θ.symm : K → H)

/-- **Proposition 76 (energy transform is unitary).**  For any Note-4 unitary
`V` (the time-Fourier transform `𝓕_P(−p⁰)`) and any linear isometry equivalence
`Θ`, the energy transform `𝓔 = Θ ∘ V ∘ Θ⁻¹` is a Note-4 unitary. -/
theorem energyTransform_unitary (Θ : H ≃ₗᵢ[𝕜] K) {V : H → H}
    (hV : IsNote4Unitary 𝕜 V) : IsNote4Unitary 𝕜 (energyTransform Θ V) :=
  note4_conj Θ hV

/-- **Proposition 76 (energy–momentum transform is unitary).**  Composing the
energy transform `𝓔` with the (unitary) Majorana–Fourier transform `𝓕_M`
(any Note-4 unitary `FM : K → K`) yields the unitary energy–momentum transform
`𝓔 ∘ 𝓕_M`. -/
theorem energyMomentum_unitary (Θ : H ≃ₗᵢ[𝕜] K) {V : H → H} {FM : K → K}
    (hV : IsNote4Unitary 𝕜 V) (hFM : IsNote4Unitary 𝕜 FM) :
    IsNote4Unitary 𝕜 (energyTransform Θ V ∘ FM) :=
  note4_comp hFM (energyTransform_unitary Θ hV)

end

/-! ## Concrete instantiation: the `L²`-Fourier transform is a Note-4 unitary -/

open MeasureTheory

variable {E F : Type*} [NormedAddCommGroup E] [MeasurableSpace E] [BorelSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

/-- **The Pauli–Fourier transform `𝓕_P` is a Note-4 unitary on `L²`.**  This is
Plancherel's theorem: Mathlib's `Lp.fourierTransformₗᵢ` is a `≃ₗᵢ[ℂ]`, hence a
Note-4 unitary. -/
theorem fourierTransform_isNote4Unitary :
    IsNote4Unitary ℂ (Lp.fourierTransformₗᵢ E F : Lp F 2 volume → Lp F 2 volume) :=
  LinearIsometryEquiv.isNote4Unitary (Lp.fourierTransformₗᵢ E F)

/-- **The concrete energy transform on `L²` is a Note-4 unitary.**  Conjugating
the `L²`-Fourier transform by any linear isometry equivalence `Θ` yields a Note-4
unitary — the honest realization of `𝓔` in the Mathlib `L²` model. -/
theorem energyTransform_fourier_unitary {K : Type*} [NormedAddCommGroup K]
    [InnerProductSpace ℂ K] (Θ : Lp F 2 volume ≃ₗᵢ[ℂ] K) :
    IsNote4Unitary ℂ (energyTransform Θ (Lp.fourierTransformₗᵢ E F)) :=
  energyTransform_unitary Θ fourierTransform_isNote4Unitary

end BookProof.ChapterMajoranaProp76
