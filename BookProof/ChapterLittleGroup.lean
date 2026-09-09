import Mathlib

/-!
# Chapter "Real representations, CPT theorem and the relativistic position operator",
§"Real unitary representations of the Poincaré group", **Definition 78 + Proposition 79**

`book.tex` (§"Real unitary representations of the Poincaré group", line ~6155):

* **Definition 78.** Given a Lorentz vector `l`, the *little group* `G_l` is the
  subgroup of `SL(2,ℂ)` of all `g` with `g \cancel l = \cancel l g`, i.e. the
  centralizer of the matrix `\cancel l`.
* **Proposition 79.** Given a Lorentz vector `l`, consider a family of matrices
  `α_k ∈ SL(2,ℂ)` verifying `α_k \cancel l = \cancel k α_k` (so `α_k` conjugates
  the base momentum matrix `\cancel l` to `\cancel k`).  Let
  `H_k ≡ {α_{Λ_S(k)}⁻¹ S α_k : S ∈ SL(2,ℂ)}`, where `Λ_S(k)` is the momentum
  obtained by the Lorentz action of `S` on `k` (`S \cancel k S⁻¹ = \cancel{Λ_S(k)}`).
  Then `H_k = G_l`.

We formalize the **purely group-theoretic content**, which needs no property of
`SL(2,ℂ)` beyond being a group.  We work in an arbitrary group `G` (the role of
`SL(2,ℂ)`) with:

* a type `K` of momenta and an **injective** map `q : K → G`, `q k = \cancel k`
  (injectivity encodes that distinct momenta give distinct Dirac-slash matrices);
* a base momentum `l₀ : K` (so `q l₀ = \cancel l`);
* the intertwiners `α : K → G` with `hα : α k * q l₀ * (α k)⁻¹ = q k`
  (the group form of `α_k \cancel l = \cancel k α_k`);
* the Lorentz action `Λ : G → K → K` with `hΛ : S * q k * S⁻¹ = q (Λ S k)`
  (every conjugate of a `\cancel k` stays on the momentum shell — the defining
  property of `Λ`).

The little group is then literally `Subgroup.centralizer {q l₀}` (Definition 78)
and `H k` is the set `{g | ∃ S, g = (α (Λ S k))⁻¹ * S * α k}` (Proposition 79's
`H_k`); the headline `prop79` proves `H k = G_l`.

**Proof.**
* `⊆`: for `h = (α (Λ S k))⁻¹ * S * α k`, conjugate `q l₀` by `h`:
  `α k` turns `q l₀` into `q k` (`hα k`), `S` turns `q k` into `q (Λ S k)` (`hΛ`),
  and `(α (Λ S k))⁻¹` turns `q (Λ S k)` back into `q l₀` (`hα (Λ S k)`).  Hence
  `h * q l₀ * h⁻¹ = q l₀`, so `h` centralizes `q l₀`.
* `⊇`: for `s` centralizing `q l₀`, set `S := α k * s * (α k)⁻¹`.  Then
  `S * q k * S⁻¹ = q k` (using `(α k)⁻¹ * q k * α k = q l₀` from `hα k` and
  `s * q l₀ * s⁻¹ = q l₀`), so `q (Λ S k) = q k`, and by injectivity `Λ S k = k`,
  whence `α (Λ S k) = α k` and `(α (Λ S k))⁻¹ * S * α k = s`.

The concrete instances of the book (`i\cancel l = iγ⁰`, `α_p = (\cancel p γ⁰ + m)/…`,
`G_l = SU(2)`; and `i\cancel l = i(γ⁰+γ³)`, `G_l = SE(2)`) are illustrations that
require the full `SL(2,ℂ)`/Dirac setup and are left as prose, matching the roadmap
constraints (off the gravity line, off the Hankel-transform line).

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.ChapterLittleGroup

variable {G : Type*} [Group G] {K : Type*}

/-- **Definition 78** (little group). Given the base momentum matrix `q l₀ = \cancel l`,
the little group `G_l` is the centralizer of `\cancel l` in the group. -/
def littleGroup (q : K → G) (l₀ : K) : Subgroup G := Subgroup.centralizer {q l₀}

/-- Membership in the little group is exactly commuting with `\cancel l` (Definition 78). -/
theorem mem_littleGroup {q : K → G} {l₀ : K} {g : G} :
    g ∈ littleGroup q l₀ ↔ q l₀ * g = g * q l₀ := by
  rw [littleGroup, Subgroup.mem_centralizer_iff]
  constructor
  · intro h; exact h (q l₀) rfl
  · intro h y hy
    rw [Set.mem_singleton_iff] at hy
    subst hy; exact h

/-- **Proposition 79**'s set `H_k = {α_{Λ_S(k)}⁻¹ S α_k : S ∈ G}`. -/
def Hset (α : K → G) (Λ : G → K → K) (k : K) : Set G :=
  {g | ∃ S : G, g = (α (Λ S k))⁻¹ * S * α k}

/-
**Proposition 79.** `H_k = G_l` for every momentum `k`.
-/
theorem prop79 (q : K → G) (hq : Function.Injective q) (l₀ : K)
    (α : K → G) (Λ : G → K → K)
    (hα : ∀ k, α k * q l₀ * (α k)⁻¹ = q k)
    (hΛ : ∀ (S : G) (k : K), S * q k * S⁻¹ = q (Λ S k))
    (k : K) :
    Hset α Λ k = (littleGroup q l₀ : Set G) := by
  -- Let's take an element g from Hset α Λ k. By definition, there exists some S such that g = (α (Λ
  -- S k))⁻¹ * S * α k.
  apply Set.eq_of_subset_of_subset;
  · intro g hg
    obtain ⟨S, rfl⟩ := hg
    have h_comm : ((α (Λ S k))⁻¹ * S * α k) * q l₀ = q l₀ * ((α (Λ S k))⁻¹ * S * α k) := by
      have h_comm : S * α k * q l₀ = q (Λ S k) * S * α k := by
        simp [ ← hΛ, mul_assoc ];
        simpa [ mul_assoc ] using eq_mul_inv_of_mul_eq ( hα k );
      have := hα ( Λ S k );
      simp [ ← this, mul_assoc, h_comm ]
    generalize_proofs at *;
    exact fun x hx => by aesop;
  · intro g hg
    use α k * g * (α k)⁻¹;
    simp_all only [mul_assoc, littleGroup, SetLike.mem_coe, Subgroup.mem_centralizer_iff,
        Set.mem_singleton_iff, forall_eq, inv_mul_cancel, mul_one];
    simp_all only [hq.eq_iff, ← mul_assoc, right_eq_mul];
    have hΛ_eq : Λ (α k * g * (α k)⁻¹) k = k := by
      have h_comm : (α k * g * (α k)⁻¹) * (α k * q l₀ * (α k)⁻¹) * (α k * g * (α k)⁻¹)⁻¹ = α k * q
          l₀ * (α k)⁻¹ := by
        simp [ mul_assoc ];
        simp [ ← mul_assoc, ← hg ];
      grind;
    rw [ hΛ_eq, inv_mul_cancel ]

end BookProof.ChapterLittleGroup
