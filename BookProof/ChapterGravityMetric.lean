import Mathlib
import BookProof.ChapterGravityProjector

/-!
# Chapter — Diffeomorphisms and gravity: the induced spatial metric `h = η + v♭⊗v♭`

Source: `book.tex`, chapter *"Diffeomorphisms and gravity"*, §*"Classical
Hamiltonian"* (line ~8091).  There, relative to the globally defined **unit
timelike vector** `v` (`vᵘ vᵤ = −1` in the mostly-plus Minkowski metric
`η = diag(−1,1,1,1)`), the author introduces the mixed projector
`χ_a{}^b = δ_a{}^b + v_a v^b` used to split every torsion tensor into its
spatial and temporal parts.  Lowering the free index of `χ` with the metric
produces the associated **`(0,2)` spatial tensor**

`h_{ab} = η_{ab} + v_a v_b`  ( `= η_{ac} χ^c{}_b` ),

the *induced (Riemannian) metric on the spatial hyperplane* `v^⊥`.  This file
records its self-contained linear-algebra properties, continuing the projector
development of `BookProof/ChapterGravityProjector.lean` (whose `metric`, `lower`,
`minkSq`, `spatialProj` are reused).

Formalized here (all under the physical unit-timelike hypothesis
`minkSq v = -1`):

* `spatialMetric v` — the symmetric matrix `h_{ab} = η_{ab} + v_a v_b`;
* `spatialMetric_symm` — `h` is symmetric (`hᵀ = h`);
* `spatialMetric_eq_metric_mul_proj` — the tensor identity `h = η · χ`
  (lowering the free index of the projector `χ`);
* `spatialMetric_mulVec_self` — `h v = 0`: `v` lies in the kernel, so `h`
  degenerates exactly along the time direction;
* `reverse_cauchy_schwarz` — the reverse Cauchy–Schwarz inequality for the
  timelike vector `v`: `⟨x,v⟩_η² ≥ −⟨x,x⟩_η`;
* `spatialMetric_quadForm_nonneg` — **headline**: the quadratic form of `h` is
  nonnegative, `0 ≤ xᵀ h x` for every `x` — i.e. `h` is positive semidefinite,
  a genuine (degenerate) Riemannian metric whose kernel is the time direction;
* `spatialMetric_posSemidef` — the packaged `Matrix.PosSemidef` statement.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); no `EXTERNAL` hypothesis, no `axiom`.
-/

namespace BookProof.ChapterGravityMetric

open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

/-- The induced spatial `(0,2)` metric `h_{ab} = η_{ab} + v_a v_b`, where
`v_a = lower v a` are the lowered components. -/
noncomputable def spatialMetric (v : Fin 4 → ℝ) : Matrix (Fin 4) (Fin 4) ℝ :=
  metric + Matrix.of (fun a b => lower v a * lower v b)

/-
`h` is symmetric.
-/
theorem spatialMetric_symm (v : Fin 4 → ℝ) :
    (spatialMetric v)ᵀ = spatialMetric v := by
      unfold spatialMetric; ext i j; simp only [lower, transpose_apply, add_apply, of_apply,
          mul_comm, add_left_inj] ;
      unfold metric; fin_cases i <;> fin_cases j <;> rfl;

/-
The tensor identity `h = η · χ`: the spatial metric is the projector `χ`
with its free index lowered by the Minkowski metric.
-/
theorem spatialMetric_eq_metric_mul_proj (v : Fin 4 → ℝ) :
    spatialMetric v = metric * spatialProj v := by
      ext a b; simp only [spatialMetric, add_apply, of_apply, spatialProj, mul_apply,
          Fin.sum_univ_four, Fin.isValue] ; ring;
      simp only [metric, Fin.isValue, lower, mulVec, dotProduct, Fin.sum_univ_four] ; ring;
      fin_cases a <;> fin_cases b <;> simp [ Matrix.one_apply ]; all_goals ring

/-
`h` annihilates the timelike vector `v` (`h v = 0`): the induced metric is
degenerate exactly along the time direction, and is genuinely Riemannian only on
the spatial hyperplane `v^⊥`.
-/
theorem spatialMetric_mulVec_self (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    (spatialMetric v).mulVec v = 0 := by
      unfold spatialMetric minkSq at *;
      unfold lower metric at *;
      ext i; simp_all [ Matrix.mulVec, dotProduct, Fin.sum_univ_four ] ;
      grind

/-
Reverse Cauchy–Schwarz for the unit timelike vector `v`: for every `x`,
`(∑ₐ xᵃ vₐ)² ≥ −(∑ₐ xᵃ xₐ)`, equivalently `⟨x,v⟩_η² ≥ −⟨x,x⟩_η`.  This is the
analytic heart of the positive-semidefiniteness of the induced spatial metric.
-/
theorem reverse_cauchy_schwarz (v x : Fin 4 → ℝ) (hv : minkSq v = -1) :
    0 ≤ (∑ a, x a * lower v a) ^ 2 + minkSq x := by
      unfold minkSq at *; norm_num [ Fin.sum_univ_four, lower ] at *;
      unfold metric at * ; norm_num [ Fin.sum_univ_four, Matrix.mulVec ] at *;
      norm_num [ Fin.ext_iff ] at *;
      by_cases h : v 1 ^ 2 + v 2 ^ 2 + v 3 ^ 2 = 0;
      · norm_num [ show v 1 = 0 by nlinarith only [ h ], show v 2 = 0
                                   by nlinarith only [ h ], show v 3 = 0
                                       by nlinarith only [ h ] ] at *;
        nlinarith [ sq_nonneg ( x 1 ), sq_nonneg ( x 2 ), sq_nonneg ( x 3 ) ];
      · -- Let's simplify the expression by setting $a = x_1 v_1 + x_2 v_2 + x_3 v_3$ and $s = v_1^2
        -- + v_2^2 + v_3^2$.
        set a := x 1 * v 1 + x 2 * v 2 + x 3 * v 3
        set s := v 1 ^ 2 + v 2 ^ 2 + v 3 ^ 2
        have h_s_pos : 0 < s := by
          exact lt_of_le_of_ne ( by positivity ) ( Ne.symm h );
        -- Substitute $a$ and $s$ into the inequality.
        have h_sub : s * ((-(x 0 * v 0) + a) ^ 2 + (-(x 0 * x 0) + x 1 * x 1 + x 2 * x 2 + x 3 * x
            3)) = (a * v 0 - x 0 * s) ^ 2 + (s * (x 1 ^ 2 + x 2 ^ 2 + x 3 ^ 2) - a ^ 2) := by
          grind;
        -- By the Lagrange identity, we know that $s * (x_1^2 + x_2^2 + x_3^2) - a^2 \geq 0$.
        have h_lagrange : s * (x 1 ^ 2 + x 2 ^ 2 + x 3 ^ 2) - a ^ 2 ≥ 0 := by
          nlinarith only [ sq_nonneg ( x 1 * v 2 - x 2 * v 1 ), sq_nonneg ( x 1 * v 3 - x 3 * v 1 ),
              sq_nonneg ( x 2 * v 3 - x 3 * v 2 ) ];
        nlinarith only [ h_sub, h_lagrange, h_s_pos ]

/-
**Headline.** The quadratic form of the induced spatial metric is
nonnegative: `0 ≤ xᵀ h x` for all `x`.  Hence `h` is positive semidefinite — a
(degenerate) Riemannian metric, positive definite on the spatial hyperplane
`v^⊥` and vanishing along `v`.
-/
theorem spatialMetric_quadForm_nonneg (v x : Fin 4 → ℝ) (hv : minkSq v = -1) :
    0 ≤ x ⬝ᵥ ((spatialMetric v).mulVec x) := by
      convert reverse_cauchy_schwarz v x hv using 1;
      unfold spatialMetric minkSq;
      unfold lower; unfold metric; simp [ Fin.sum_univ_four, Matrix.mulVec, dotProduct ] ; ring;

/-
The packaged positive-semidefiniteness of the induced spatial metric.
-/
theorem spatialMetric_posSemidef (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    (spatialMetric v).PosSemidef := by
      constructor;
      · ext i j; simp only [spatialMetric, conjTranspose_apply, add_apply, of_apply, star_trivial] ;
        unfold metric; fin_cases i <;> fin_cases j <;> simp [ mul_comm ] ;
      · intro x;
        convert spatialMetric_quadForm_nonneg v ( fun i => x i ) hv using 1;
        simp [ Finsupp.sum_fintype, dotProduct, Matrix.mulVec, Finset.mul_sum _ _ _, mul_comm,
            mul_left_comm ]

end BookProof.ChapterGravityMetric
