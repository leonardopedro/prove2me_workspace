import Definitions.Def_ChapterHermiteCarlemanEsa
import Mathlib


/-!
# A two-step Carleman criterion on the multi-index lattice

`BookProof.ChapterHermiteCarlemanEsa` proves a Carleman criterion for a *nearest
neighbour* recursion on the lattice of multi-indices: the hops are `α ↦ α ± eᵢ`, with
amplitudes of size `O(√αᵢ)`.  That is exactly the ladder structure of a **diagonal**
quadratic Hamiltonian `∑ᵢ cᵢ(πᵢ² + xᵢ²/4)` plus a first-order term.

A general **mode-diagonal** quadratic Hamiltonian

`H = ∑ᵢ (pᵢπᵢ² + qᵢxᵢ² + sᵢ·½(xᵢπᵢ + πᵢxᵢ)) + ∑ᵢ (bᵢxᵢ + b'ᵢπᵢ)`

is not of that form: `xᵢ²`, `πᵢ²` and the squeezing generator `½(xᵢπᵢ + πᵢxᵢ)` all
contain `aᵢ†²` and `aᵢ²`, which move the `i`-th excitation number by **two**, with an
amplitude of size `O(αᵢ)`.  This module proves the Carleman criterion for such a
recursion: hops `α ↦ α ± eᵢ` *and* `α ↦ α ± 2eᵢ`, with amplitudes `O(N)` on the boundary
of the cube `{α : ∀ i, αᵢ ≤ N}`.

## What is proved

* `innK`, `faceK` — the interior and the `k`-thick boundary face of a cube in a fixed
  direction; `sum_shiftK`, `sum_cube_splitK` — the reindexing and splitting identities.
* `rtermG`, `ltermG`, `sum_cube_hop_im` — **the abstract flux cancellation**: for a
  single Hermitian hop family of step `k`, the interior contributions occur in conjugate
  pairs, so the imaginary part of the total contribution over a cube is carried entirely
  by the `k`-thick boundary face.
* `LadderRec2`, `flux_identity2` — the two-step recursion and its flux identity.
* `flux_boundG` — the flux through a face is at most the amplitude bound there times the
  `ℓ²`-mass carried by the face and its shift.
* `sum_range_of_multiplicity`, `faceK_multiplicity`, `shiftedK_multiplicity` — Bessel's
  inequality with multiplicity: a `k`-thick face meets at most `k` cubes, so the total
  face mass is at most `k` times the total mass.  (For `k = 1` the faces are disjoint;
  for `k = 2` they are not, and this is what replaces disjointness.)
* `ladder2_eq_zero` — **the criterion.**  A square-summable family satisfying the
  two-step recursion with a real diagonal and constant amplitudes, at a point off the
  real axis, vanishes.  The Carleman divergence used is `∑ 1/(N+1) = ∞`.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.CarlemanTwoStep

open Finset
open BookProof.HermiteCarleman

noncomputable section

variable {d : ℕ}

/-! ## 1. Cubes with a step -/

/-- The part of the cube that can still be raised by `k` in the direction `i` without
leaving the cube. -/
def innK (d N : ℕ) (i : Fin d) (k : ℕ) : Finset (Fin d →₀ ℕ) :=
  (cube d N).filter (fun a => a i + k ≤ N)

/-- The `k`-thick boundary face of the cube in the direction `i`. -/
def faceK (d N : ℕ) (i : Fin d) (k : ℕ) : Finset (Fin d →₀ ℕ) :=
  (cube d N).filter (fun a => N < a i + k)







tice

`BookProof.ChapterHermiteCarlemanEsa` proves a Carleman criterion for a *nearest
neighbour* recursion on the lattice of multi-indices: the hops are `α ↦ α ± eᵢ`, with
amplitudes of size `O(√αᵢ)`.  That is exactly the ladder structure of a **diagonal**
quadratic Hamiltonian `∑ᵢ cᵢ(πᵢ² + xᵢ²/4)` plus a first-order term.

A general **mode-diagonal** quadratic Hamiltonian

`H = ∑ᵢ (pᵢπᵢ² + qᵢxᵢ² + sᵢ·½(xᵢπᵢ + πᵢxᵢ)) + ∑ᵢ (bᵢxᵢ + b'ᵢπᵢ)`

is not of that form: `xᵢ²`, `πᵢ²` and the squeezing generator `½(xᵢπᵢ + πᵢxᵢ)` all
contain `aᵢ†²` and `aᵢ²`, which move the `i`-th excitation number by **two**, with an
amplitude of size `O(αᵢ)`.  This module proves the Carleman criterion for such a
recursion: hops `α ↦ α ± eᵢ` *and* `α ↦ α ± 2eᵢ`, with amplitudes `O(N)` on the boundary
of the cube `{α : ∀ i, αᵢ ≤ N}`.

## What is proved

* `innK`, `faceK` — the interior and the `k`-thick boundary face of a cube in a fixed
  direction; `sum_shiftK`, `sum_cube_splitK` — the reindexing and splitting identities.
* `rtermG`, `ltermG`, `sum_cube_hop_im` — **the abstract flux cancellation**: for a
  single Hermitian hop family of step `k`, the interior contributions occur in conjugate
  pairs, so the imaginary part of the total contribution over a cube is carried entirely
  by the `k`-thick boundary face.
* `LadderRec2`, `flux_identity2` — the two-step recursion and its flux identity.
* `flux_boundG` — the flux through a face is at most the amplitude bound there times the
  `ℓ²`-mass carried by the face and its shift.
* `sum_range_of_multiplicity`, `faceK_multiplicity`, `shiftedK_multiplicity` — Bessel's
  inequality with multiplicity: a `k`-thick face meets at most `k` cubes, so the total
  face mass is at most `k` times the total mass.  (For `k = 1` the faces are disjoint;
  for `k = 2` they are not, and this is what replaces disjointness.)
* `ladder2_eq_zero` — **the criterion.**  A square-summable family satisfying the
  two-step recursion with a real diagonal and constant amplitudes, at a point off the
  real axis, vanishes.  The Carleman divergence used is `∑ 1/(N+1) = ∞`.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.CarlemanTwoStep

open Finset
open BookProof.HermiteCarleman

noncomputable section

variable {d : ℕ}

/-! ## 1. Cubes with a step -/

/-- The part of the cube that can still be raised by `k` in the direction `i` without
leaving the cube. -/
def innK (d N : ℕ) (i : Fin d) (k : ℕ) : Finset (Fin d →₀ ℕ) :=
  (cube d N).filter (fun a => a i + k ≤ N)

/-- The `k`-thick boundary face of the cube in the direction `i`. -/
def faceK (d N : ℕ) (i : Fin d) (k : ℕ) : Finset (Fin d →₀ ℕ) :=
  (cube d N).filter (fun a => N < a i + k)

theorem mem_innK {d N : ℕ} {i : Fin d} {k : ℕ} {a : Fin d →₀ ℕ} :
    a ∈ innK d N i k ↔ (∀ j, a j ≤ N) ∧ a i + k ≤ N := by
  classical
  rw [innK, Finset.mem_filter, mem_cube]

theorem mem_faceK {d N : ℕ} {i : Fin d} {k : ℕ} {a : Fin d →₀ ℕ} :
    a ∈ faceK d N i k ↔ (∀ j, a j ≤ N) ∧ N < a i + k := by
  classical
  rw [faceK, Finset.mem_filter, mem_cube]

theorem sub_add_singleK {d : ℕ} {i : Fin d} {k : ℕ} {a : Fin d →₀ ℕ} (h : k ≤ a i) :
    (a - Finsupp.single i k) + Finsupp.single i k = a := by
  ext j
  by_cases hj : j = i
  · subst hj; simp; omega
  · simp [hj]

theorem sub_singleK_apply {d : ℕ} {i : Fin d} {k : ℕ} {a : Fin d →₀ ℕ} :
    (a - Finsupp.single i k : Fin d →₀ ℕ) i = a i - k := by
  simp [Finsupp.tsub_apply]

/-- Reindexing a sum which vanishes on the bottom `k` layers along the shift
`α ↦ α + k eᵢ`. -/
theorem sum_shiftK (d N : ℕ) (i : Fin d) (k : ℕ) (F : (Fin d →₀ ℕ) → ℂ)
    (hF : ∀ a : Fin d →₀ ℕ, a i < k → F a = 0) :
    ∑ a ∈ cube d N, F a = ∑ b ∈ innK d N i k, F (b + Finsupp.single i k) := by
  classical
  rw [← Finset.sum_filter_of_ne (p := fun a : Fin d →₀ ℕ => k ≤ a i)
    (fun a _ hne => by by_contra hlt; exact hne (hF a (by omega)))]
  refine Finset.sum_nbij' (fun a => a - Finsupp.single i k) (fun b => b + Finsupp.single i k)
    ?_ ?_ ?_ ?_ ?_
  · intro a ha
    simp only [Finset.mem_filter, mem_cube] at ha
    rw [mem_innK]
    refine ⟨fun j => le_trans (by simp [Finsupp.tsub_apply]) (ha.1 j), ?_⟩
    rw [sub_singleK_apply]
    have h2 := ha.1 i
    have h3 := ha.2
    omega
  · intro b hb
    rw [mem_innK] at hb
    simp only [Finset.mem_filter, mem_cube]
    refine ⟨fun j => ?_, ?_⟩
    · by_cases hj : j = i
      · subst hj; simp; omega
      · simpa [hj] using hb.1 j
    · simp
  · intro a ha
    simp only [Finset.mem_filter] at ha
    exact sub_add_singleK ha.2
  · intro b _; simp
  · intro a ha
    simp only [Finset.mem_filter] at ha
    rw [sub_add_singleK ha.2]



/-! ## 2. The abstract flux cancellation for one hop family -/

variable {u : (Fin d →₀ ℕ) → ℂ}

/-- The raising contribution of a hop of step `k` in the direction `i`. -/
def rtermG (u : (Fin d →₀ ℕ) → ℂ) (w : ℂ) (rc : (Fin d →₀ ℕ) → Fin d → ℝ) (k : ℕ) (i : Fin d)
    (a : Fin d →₀ ℕ) : ℂ :=
  (starRingEnd ℂ) w * ((rc a i : ℝ) : ℂ) * (starRingEnd ℂ) (u a) * u (a + Finsupp.single i k)

/-- The lowering contribution of a hop of step `k` in the direction `i`. -/
def ltermG (u : (Fin d →₀ ℕ) → ℂ) (w : ℂ) (lc : (Fin d →₀ ℕ) → Fin d → ℝ) (k : ℕ) (i : Fin d)
    (a : Fin d →₀ ℕ) : ℂ :=
  w * ((lc a i : ℝ) : ℂ) * (starRingEnd ℂ) (u a) * u (a - Finsupp.single i k)







/-! ## 3. The two-step recursion -/

/-- The raising coefficient of a one-step hop: `√(αᵢ+1)`. -/
def rc1 (a : Fin d →₀ ℕ) (i : Fin d) : ℝ := Real.sqrt ((a i : ℝ) + 1)

/-- The lowering coefficient of a one-step hop: `√αᵢ`. -/
def lc1 (a : Fin d →₀ ℕ) (i : Fin d) : ℝ := Real.sqrt (a i : ℝ)

/-- The raising coefficient of a two-step hop: `√((αᵢ+1)(αᵢ+2))`. -/
def rc2 (a : Fin d →₀ ℕ) (i : Fin d) : ℝ := Real.sqrt (((a i : ℝ) + 1) * ((a i : ℝ) + 2))

/-- The lowering coefficient of a two-step hop: `√(αᵢ(αᵢ−1))`. -/
def lc2 (a : Fin d →₀ ℕ) (i : Fin d) : ℝ := Real.sqrt ((a i : ℝ) * ((a i : ℝ) - 1))













/-- **The two-step recursion.**  A real diagonal `lam`, one-step amplitudes `w1` and
two-step amplitudes `w2`, at the point `z`. -/
def LadderRec2 (u : (Fin d →₀ ℕ) → ℂ) (lam : (Fin d →₀ ℕ) → ℝ) (w1 w2 : Fin d → ℂ) (z : ℂ) :
    Prop :=
  ∀ a : Fin d →₀ ℕ,
    ((lam a : ℝ) : ℂ) * u a
      + ∑ i, ((starRingEnd ℂ) (w1 i) * ((rc1 a i : ℝ) : ℂ) * u (a + Finsupp.single i 1)
            + w1 i * ((lc1 a i : ℝ) : ℂ) * u (a - Finsupp.single i 1))
      + ∑ i, ((starRingEnd ℂ) (w2 i) * ((rc2 a i : ℝ) : ℂ) * u (a + Finsupp.single i 2)
            + w2 i * ((lc2 a i : ℝ) : ℂ) * u (a - Finsupp.single i 2))
      = z * u a

variable {lam : (Fin d →₀ ℕ) → ℝ} {w1 w2 : Fin d → ℂ} {z : ℂ}



/-! ## 4. The flux bound -/



/-! ## 5. Bessel's inequality with multiplicity -/













/-! ## 6. The criterion -/



end

end BookProof.CarlemanTwoStep
