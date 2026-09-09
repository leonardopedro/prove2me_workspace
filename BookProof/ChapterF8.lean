import Mathlib
import BookProof.ChapterF1

/-!
# Chapter F8 — Tomographic Subspace Recovery: the offline compilation
(plan Part F.3, roadmap §10)

`QFM.tex` §10 describes the *Tomographic Subspace Recovery* pipeline.  Its
offline stage compiles the raw corpus into two objects that the online stage then
uses without ever touching the corpus again:

* a **two-level sketch** `S₂ ∘ S₁`, where `S₁ : ℝ^d → ℝ^k` hashes raw coordinates
  into `k ≪ d` features and `S₂ : ℝ^k → Fock(K₂)` places the features on `k`
  distinct modes of a `K₂`-mode Fock space (`K₂ > k`), producing a
  **single-excitation** state; and
* an **operator basis** of the reduced `m`-dimensional Krylov space, consisting
  of `m²` matrix units, into which all raw-coordinate observables are
  pre-projected.

The point of the construction is a cost statement: the corpus size `M` occurs
only in the offline stage, so the online cost carries **no** `M` term.

## Deliverables

* `featureHash` (`S₁`) and `fockEmbed` (`S₂`), `singleExcitation` — the
  single-excitation subspace of the `K₂`-mode Fock space;
* `fockEmbed_mem_singleExcitation`, `twoLevelHash_total` — `S₂ ∘ S₁` is a
  well-defined map of *every* raw vector into the single-excitation subspace;
* `featureHash_decodes` — the sketch is lossless on the feature layer: reading
  the mode `g j` of `S₂ y` returns the feature `y j` (for an injective mode
  assignment `g`), and `twoLevelHash_decodes` composes this with `S₁`;
* `offline_operatorBasis` — the `m²` pre-projected matrix units span the whole
  operator space `Hom(ℂ^m, ℂ^m)`, so the offline basis is complete;
* `online_cost_independent_of_M` — the corpus size enters only through the
  offline term: changing `M` changes the total cost exactly by the change of the
  offline cost;
* `tsr_offline_compiles` — **headline**: the offline stage produces the sketched
  single-excitation embedding *and* a complete `m²` operator basis, and the
  online cost is `M`-free.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

noncomputable section

open scoped BigOperators

namespace BookProof.ChapterF8

/-! ## The two-level sketch -/

/-- Occupation vectors of a `K`-mode bosonic Fock space. -/
abbrev Occ (K : ℕ) := Fin K →₀ ℕ

/-- The `K`-mode Fock space, spanned by occupation-number basis states. -/
abbrev FockSpace (K : ℕ) := Occ K →₀ ℂ

/-- The **single-excitation subspace**: the span of the states `|1_a⟩` carrying
exactly one boson, in mode `a`. -/
def singleExcitation (K : ℕ) : Submodule ℂ (FockSpace K) :=
  Submodule.span ℂ {v | ∃ a : Fin K, v = Finsupp.single (Finsupp.single a 1) (1 : ℂ)}

/-- **`S₁` — the raw→feature hash.**  Raw coordinate `i` is added into feature
bucket `h i`; the feature dimension `k` is far below the raw dimension `d`. -/
def featureHash {d k : ℕ} (h : Fin d → Fin k) (x : Fin d → ℝ) : Fin k → ℝ :=
  fun j => ∑ i ∈ Finset.univ.filter (fun i => h i = j), x i

/-- **`S₂` — the feature→Fock embedding.**  Feature `j` is placed, with its own
amplitude, on the mode `g j` of the `K₂`-mode Fock space; `g` is injective, so
distinct features occupy distinct modes (`K₂ > k`). -/
def fockEmbed {k K : ℕ} (g : Fin k → Fin K) (y : Fin k → ℝ) : FockSpace K :=
  ∑ j : Fin k, (y j : ℂ) • Finsupp.single (Finsupp.single (g j) 1) (1 : ℂ)

/-- The composite two-level sketch `S₂ ∘ S₁`. -/
def twoLevelHash {d k K : ℕ} (h : Fin d → Fin k) (g : Fin k → Fin K)
    (x : Fin d → ℝ) : FockSpace K :=
  fockEmbed g (featureHash h x)

/-- `S₂` really lands in the single-excitation sector. -/
theorem fockEmbed_mem_singleExcitation {k K : ℕ} (g : Fin k → Fin K) (y : Fin k → ℝ) :
    fockEmbed g y ∈ singleExcitation K := by
  rw [fockEmbed]
  refine Submodule.sum_mem _ fun j _ => Submodule.smul_mem _ _ ?_
  exact Submodule.subset_span ⟨g j, rfl⟩

/-- **F.3 — the two-level hash is total.**  Every raw vector is mapped by
`S₂ ∘ S₁` to a well-defined state of the single-excitation subspace. -/
theorem twoLevelHash_total {d k K : ℕ} (h : Fin d → Fin k) (g : Fin k → Fin K)
    (x : Fin d → ℝ) : twoLevelHash h g x ∈ singleExcitation K :=
  fockEmbed_mem_singleExcitation g (featureHash h x)

/-- **F.3 — the feature layer decodes.**  Reading the amplitude of the
one-boson state on mode `g j` returns exactly the feature `y j`; the mode
assignment being injective is what makes the readout unambiguous. -/
theorem featureHash_decodes {k K : ℕ} (g : Fin k → Fin K) (hg : Function.Injective g)
    (y : Fin k → ℝ) (j : Fin k) :
    fockEmbed g y (Finsupp.single (g j) 1) = (y j : ℂ) := by
  classical
  rw [fockEmbed, Finsupp.finset_sum_apply]
  have hterm : ∀ i : Fin k,
      ((y i : ℂ) • Finsupp.single (Finsupp.single (g i) 1) (1 : ℂ)) (Finsupp.single (g j) 1)
        = if i = j then (y j : ℂ) else 0 := by
    intro i
    rw [Finsupp.smul_single, smul_eq_mul, mul_one, Finsupp.single_apply]
    by_cases hij : i = j
    · subst hij; simp
    · have hne : Finsupp.single (g i) 1 ≠ Finsupp.single (g j) (1 : ℕ) := by
        intro hc
        exact hij (hg (Finsupp.single_left_injective one_ne_zero hc))
      simp [hne, hij]
  rw [Finset.sum_congr rfl fun i _ => hterm i]
  simp

/-- The composite readout: the mode `g j` of the sketched state carries the
`j`-th hashed feature of the raw vector. -/
theorem twoLevelHash_decodes {d k K : ℕ} (h : Fin d → Fin k) (g : Fin k → Fin K)
    (hg : Function.Injective g) (x : Fin d → ℝ) (j : Fin k) :
    twoLevelHash h g x (Finsupp.single (g j) 1) = ((featureHash h x j : ℝ) : ℂ) :=
  featureHash_decodes g hg (featureHash h x) j

/-! ## The offline operator basis -/

/-- The `m²` matrix units of the reduced Krylov space — the operator basis into
which all raw-coordinate observables are pre-projected offline. -/
def operatorBasis (m : ℕ) : Set (Matrix (Fin m) (Fin m) ℂ) :=
  Set.range fun p : Fin m × Fin m => Matrix.single p.1 p.2 (1 : ℂ)

/-- The offline basis has exactly `m²` elements' worth of indices. -/
theorem operatorBasis_card (m : ℕ) : Fintype.card (Fin m × Fin m) = m * m := by
  simp

/-- **F.3 — the offline operator basis is complete.**  The `m²` pre-projected
matrix units span the whole operator space `Hom(ℂ^m, ℂ^m)`, so every observable
of the reduced space is already available offline. -/
theorem offline_operatorBasis (m : ℕ) :
    Submodule.span ℂ (operatorBasis m) = ⊤ := by
  refine Submodule.eq_top_iff'.mpr fun A => ?_
  rw [Matrix.matrix_eq_sum_single A]
  refine Submodule.sum_mem _ fun i _ => Submodule.sum_mem _ fun j _ => ?_
  have hscale : Matrix.single i j (A i j) = A i j • Matrix.single i j (1 : ℂ) := by
    ext a b
    by_cases ha : a = i <;> by_cases hb : b = j <;>
      simp [Matrix.single, ha, hb]
  rw [hscale]
  exact Submodule.smul_mem _ _ (Submodule.subset_span ⟨(i, j), rfl⟩)

/-! ## The cost split -/

/-- The offline cost: the only stage that touches the corpus of size `M`. -/
def offlineCost (M d k : ℕ) : ℕ := M * d * k

/-- The four online cost components of §10 — sketching `O(d·m²)`, hashing
`O(K₂ log k)`, Fock assembly `O(K₂·m²)` and the reduced generation `O(m²)`.
Note the absence of any `M`. -/
def onlineCost (d m K₂ k : ℕ) : ℕ :=
  d * m ^ 2 + K₂ * Nat.log 2 k + K₂ * m ^ 2 + m ^ 2

/-- The total pipeline cost. -/
def totalCost (M d m K₂ k : ℕ) : ℕ := offlineCost M d k + onlineCost d m K₂ k

/-- **F.3 — the online cost carries no `M` term.**  Changing the corpus size
changes the total cost exactly by the change of the *offline* cost: the online
stage is independent of `M`. -/
theorem online_cost_independent_of_M (M M' d m K₂ k : ℕ) :
    totalCost M d m K₂ k + offlineCost M' d k
      = totalCost M' d m K₂ k + offlineCost M d k := by
  rw [totalCost, totalCost]
  omega

/-- The same statement in its pointwise form: the online term is literally a
function of `(d, m, K₂, k)` alone. -/
theorem totalCost_sub_offline (M d m K₂ k : ℕ) :
    totalCost M d m K₂ k - offlineCost M d k = onlineCost d m K₂ k := by
  rw [totalCost]
  omega

/-- **Headline (F.3).**  The offline stage of Tomographic Subspace Recovery
compiles: it produces (i) the two-level sketch, which maps every raw vector into
the single-excitation subspace and decodes the features back, and (ii) a complete
`m²` operator basis of the reduced space; and the resulting online cost is free
of the corpus size `M`. -/
theorem tsr_offline_compiles {d k K₂ m : ℕ} (h : Fin d → Fin k) (g : Fin k → Fin K₂)
    (hg : Function.Injective g) :
    (∀ x : Fin d → ℝ, twoLevelHash h g x ∈ singleExcitation K₂) ∧
    (∀ (x : Fin d → ℝ) (j : Fin k),
      twoLevelHash h g x (Finsupp.single (g j) 1) = ((featureHash h x j : ℝ) : ℂ)) ∧
    Submodule.span ℂ (operatorBasis m) = ⊤ ∧
    (∀ M M' : ℕ, totalCost M d m K₂ k + offlineCost M' d k
      = totalCost M' d m K₂ k + offlineCost M d k) :=
  ⟨fun x => twoLevelHash_total h g x,
   fun x j => twoLevelHash_decodes h g hg x j,
   offline_operatorBasis m,
   fun M M' => online_cost_independent_of_M M M' d m K₂ k⟩

end BookProof.ChapterF8

end
