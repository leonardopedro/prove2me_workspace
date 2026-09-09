import Mathlib
import BookProof.ChapterDirectSumEsa

/-!
# The edge of an orthogonal direct sum: fibre edges glue to their infimum

Plan item **QG-3.4 (derived case)** of `CONSOLIDATED_PLAN.md` needs the
following purely structural fact, stated there informally as "the quadratic
form of the direct sum is the sum of the fibre forms, each `≥` its edge times
the fibre norm square, and `‖ψ‖² = Σᵢ ‖ψᵢ‖²":

> if every fibre operator `Hᵢ` satisfies a form bound
> `⟪u, Hᵢ u⟫ ≥ νᵢ‖u‖²` on its core `Dᵢ`, then the direct sum `⊕ᵢ Hᵢ`
> satisfies `⟪x, (⊕ᵢHᵢ) x⟫ ≥ ν‖x‖²` on the glued core `⊕ᵃˡᵍ Dᵢ`
> for any common lower bound `ν ≤ νᵢ`.

This module proves it, on the `dsCore`/`dsOp` direct sum of
`BookProof.ChapterDirectSumEsa`:

* `inner_dsCore_self_eq_sum`, `inner_dsOp_eq_sum` — on the algebraic direct
  sum both the norm and the energy are *finite* sums over the (finite)
  support of the state, so no summability side condition ever arises;
* `norm_sq_dsCore_eq_sum` — `‖x‖² = Σᵢ ‖xᵢ‖²` on the core;
* `quadForm_dsOp_eq_sum` — the quadratic form of `⊕ᵢHᵢ` is the sum of the
  fibre quadratic forms;
* **`dsOp_edge_of_fibre_edges`** — the edge statement itself, with a uniform
  bound `ν`;
* **`dsOp_edge_of_fibre_edges_le`** — the form the plan uses: fibre edges
  `νᵢ` and any `ν` with `ν ≤ νᵢ` for all `i` (e.g. `ν = min(ω₁/2, …, E₀)`);
* `dsOp_edge_pos` — the strict-positivity packaging: a positive common lower
  bound of the fibre edges is a strict one-particle edge of the glued
  operator.

## Honest boundary

This is the *derived* half of QG-3.4 only: it converts fibre edges into an
edge of the glued operator and asserts nothing about the fibre edges
themselves, nor about whether the physical operator of record decomposes as
such a direct sum (that is the QG-3.2(a) question).  A strict edge on a core
is a one-particle form bound, not a spectral gap of any Fock Hamiltonian.

Everything in this module is `sorry`-free and `axiom`-free.
-/

namespace BookProof.DirectSumEdge

open BookProof.FarisLavine BookProof.DirectSumEsa

noncomputable section

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)] {D : ∀ i, Submodule ℂ (G i)}

/-- The support finset of a state of the algebraic direct sum. -/
def supportFinset (x : dsCore D) : Finset ι := x.2.1.toFinset

theorem mem_supportFinset {x : dsCore D} {i : ι} :
    i ∈ supportFinset x ↔ ((x : lp G 2) : ∀ i, G i) i ≠ 0 :=
  x.2.1.mem_toFinset

theorem coe_eq_zero_of_notMem_supportFinset {x : dsCore D} {i : ι}
    (hi : i ∉ supportFinset x) : ((x : lp G 2) : ∀ i, G i) i = 0 := by
  by_contra hne
  exact hi (mem_supportFinset.mpr hne)

/-- **On the algebraic direct sum, the inner product is a finite sum.** -/
theorem inner_dsCore_eq_sum (x : dsCore D) (g : lp G 2) :
    (inner ℂ (x : lp G 2) g : ℂ)
      = ∑ i ∈ supportFinset x,
          (inner ℂ (((x : lp G 2) : ∀ i, G i) i) ((g : ∀ i, G i) i) : ℂ) := by
  rw [lp.inner_eq_tsum]
  refine tsum_eq_sum fun i hi => ?_
  rw [coe_eq_zero_of_notMem_supportFinset hi, inner_zero_left]

/-- The squared norm on the algebraic direct sum is a finite sum of fibre
squared norms. -/
theorem norm_sq_dsCore_eq_sum (x : dsCore D) :
    ‖(x : lp G 2)‖ ^ 2 = ∑ i ∈ supportFinset x, ‖((x : lp G 2) : ∀ i, G i) i‖ ^ 2 := by
  have h := inner_dsCore_eq_sum x (x : lp G 2)
  have h' := congrArg Complex.re h
  rw [Complex.re_sum] at h'
  have hleft : (inner ℂ (x : lp G 2) (x : lp G 2) : ℂ).re = ‖(x : lp G 2)‖ ^ 2 :=
    inner_self_eq_norm_sq (𝕜 := ℂ) _
  rw [hleft] at h'
  refine h'.trans (Finset.sum_congr rfl fun i _ => ?_)
  exact inner_self_eq_norm_sq (𝕜 := ℂ) _

/-- **The energy of the direct sum is the sum of the fibre energies.** -/
theorem inner_dsOp_eq_sum (H : ∀ i, D i →ₗ[ℂ] G i) (x : dsCore D) :
    (inner ℂ (x : lp G 2) (dsOp H x : lp G 2) : ℂ)
      = ∑ i ∈ supportFinset x,
          (inner ℂ (((x : lp G 2) : ∀ i, G i) i)
            (H i ⟨((x : lp G 2) : ∀ i, G i) i, x.2.2 i⟩) : ℂ) := by
  rw [inner_dsCore_eq_sum x (dsOp H x : lp G 2)]
  exact Finset.sum_congr rfl fun i _ => by rw [dsOp_coe]

/-- **The quadratic form of the direct sum is the sum of the fibre quadratic
forms.** -/
theorem quadForm_dsOp_eq_sum (H : ∀ i, D i →ₗ[ℂ] G i) (x : dsCore D) :
    quadForm (dsOp H) x
      = ∑ i ∈ supportFinset x,
          quadForm (H i) ⟨((x : lp G 2) : ∀ i, G i) i, x.2.2 i⟩ := by
  unfold quadForm
  rw [inner_dsOp_eq_sum H x, Complex.re_sum]

/-- **The edge of an orthogonal direct sum, uniform version.**  If every fibre
operator obeys the form bound `⟪u, Hᵢu⟫ ≥ ν‖u‖²` on its core, then the direct
sum obeys `⟪x, (⊕ᵢHᵢ)x⟫ ≥ ν‖x‖²` on the glued core. -/
theorem dsOp_edge_of_fibre_edges (H : ∀ i, D i →ₗ[ℂ] G i) (nu : ℝ)
    (hedge : ∀ i (u : D i), nu * ‖(u : G i)‖ ^ 2 ≤ quadForm (H i) u) (x : dsCore D) :
    nu * ‖(x : lp G 2)‖ ^ 2 ≤ quadForm (dsOp H) x := by
  rw [quadForm_dsOp_eq_sum H x, norm_sq_dsCore_eq_sum x, Finset.mul_sum]
  exact Finset.sum_le_sum fun i _ =>
    hedge i ⟨((x : lp G 2) : ∀ i, G i) i, x.2.2 i⟩

/-- **The edge of an orthogonal direct sum, the form the plan uses.**  Fibre
edges `νᵢ` and any common lower bound `ν ≤ νᵢ` (for a finite family, `ν` may
be taken to be the minimum of the fibre edges) give an edge of the glued
operator. -/
theorem dsOp_edge_of_fibre_edges_le (H : ∀ i, D i →ₗ[ℂ] G i) (nu : ℝ) (nus : ι → ℝ)
    (hle : ∀ i, nu ≤ nus i)
    (hedge : ∀ i (u : D i), nus i * ‖(u : G i)‖ ^ 2 ≤ quadForm (H i) u) (x : dsCore D) :
    nu * ‖(x : lp G 2)‖ ^ 2 ≤ quadForm (dsOp H) x := by
  refine dsOp_edge_of_fibre_edges H nu (fun i u => le_trans ?_ (hedge i u)) x
  exact mul_le_mul_of_nonneg_right (hle i) (sq_nonneg _)

/-- **A positive common lower bound of the fibre edges is a strict edge of the
glued operator**: the quadratic form is `≥ ν‖x‖²` with `ν > 0`, hence strictly
positive on every non-zero state of the core. -/
theorem dsOp_edge_pos (H : ∀ i, D i →ₗ[ℂ] G i) {nu : ℝ} (hnu : 0 < nu) (nus : ι → ℝ)
    (hle : ∀ i, nu ≤ nus i)
    (hedge : ∀ i (u : D i), nus i * ‖(u : G i)‖ ^ 2 ≤ quadForm (H i) u) (x : dsCore D)
    (hx : (x : lp G 2) ≠ 0) :
    0 < quadForm (dsOp H) x :=
  lt_of_lt_of_le
    (mul_pos hnu (pow_pos (norm_pos_iff.mpr hx) 2))
    (dsOp_edge_of_fibre_edges_le H nu nus hle hedge x)

end

end BookProof.DirectSumEdge
