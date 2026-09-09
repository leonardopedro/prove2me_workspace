import Mathlib
import BookProof.ChapterAttentionOutput
import BookProof.ChapterAttentionQKCircuit

/-!
# Chapter "The Coherent State of Attention": what the head writes

`ChapterAttentionQKCircuit` shows that the two learned projections on the *reading*
side of a head enter only through the single matrix `W_Qᵀ W_K`.  The same is true
on the *writing* side.  A head produces its contribution to the residual stream by
projecting each token down with a value map `W_V`, averaging with the attention
weights, and projecting back up with an output map `W_O`; because the average is
linear, the two matrices act only through their product `W_O W_V` — the *OV
circuit*.

* `mulVec_headOutput` — the head commutes with every linear map: averaging and then
  projecting is projecting and then averaging;
* `ovOutput_eq_headOutput` — **the headline**: the head's contribution is the
  attention average of the OV-transformed tokens, so only `W_O W_V` is observable;
* `ovOutput_congr_of_ovMatrix_eq` and `ovOutput_gauge` — two factorizations with the
  same product are indistinguishable, and `(W_O, W_V) ↦ (W_O A, B W_V)` with
  `A B = 1` is the head's `GL(d)` gauge freedom on the writing side;
* `rank_ovMatrix_le` — the OV circuit has rank at most the head dimension `d`;
* `ovOutput_mem_range` — so whatever the width of the stream, a head can only write
  into the (at most `d`-dimensional) column space of its output map.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterAttentionOVCircuit

open Matrix BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
  BookProof.ChapterObservableExpectation BookProof.ChapterAttentionOutput

variable {d n p m : ℕ}

/-! ## The head commutes with linear maps -/

/-- **Averaging commutes with projecting.**  A matrix applied to the attention
average of a family of vectors is the attention average of the transformed
family. -/
theorem mulVec_headOutput (A : Matrix (Fin p) (Fin n) ℝ) (beta : ℝ) (s : Fin m → ℝ)
    (v : Fin m → (Fin n → ℝ)) :
    A *ᵥ headOutput beta s v = headOutput beta s (fun j => A *ᵥ v j) := by
  rw [headOutput_eq_sum, headOutput_eq_sum, Matrix.mulVec_sum]
  exact Finset.sum_congr rfl fun j _ => Matrix.mulVec_smul A (scoreSoftmax beta s j) (v j)

/-! ## The OV circuit -/

/-- The **OV circuit** of a head: the single matrix through which the value and
output projections act on the residual stream. -/
def ovMatrix (WO : Matrix (Fin n) (Fin d) ℝ) (WV : Matrix (Fin d) (Fin n) ℝ) :
    Matrix (Fin n) (Fin n) ℝ := WO * WV

/-- The contribution a head writes back into the residual stream. -/
def ovOutput (beta : ℝ) (s : Fin m → ℝ) (WO : Matrix (Fin n) (Fin d) ℝ)
    (WV : Matrix (Fin d) (Fin n) ℝ) (x : Fin m → (Fin n → ℝ)) : Fin n → ℝ :=
  WO *ᵥ headOutput beta s (fun j => WV *ᵥ x j)

/-- **HEADLINE — the head only sees `W_O W_V`.**  Its contribution is the attention
average of the tokens transformed by the OV circuit. -/
theorem ovOutput_eq_headOutput (beta : ℝ) (s : Fin m → ℝ) (WO : Matrix (Fin n) (Fin d) ℝ)
    (WV : Matrix (Fin d) (Fin n) ℝ) (x : Fin m → (Fin n → ℝ)) :
    ovOutput beta s WO WV x = headOutput beta s (fun j => ovMatrix WO WV *ᵥ x j) := by
  rw [ovOutput, mulVec_headOutput]
  exact congrArg _ (funext fun j => by rw [ovMatrix, Matrix.mulVec_mulVec])

/-- Two factorizations with the same OV circuit write the same thing. -/
theorem ovOutput_congr_of_ovMatrix_eq (beta : ℝ) (s : Fin m → ℝ)
    {WO₁ WO₂ : Matrix (Fin n) (Fin d) ℝ} {WV₁ WV₂ : Matrix (Fin d) (Fin n) ℝ}
    (h : ovMatrix WO₁ WV₁ = ovMatrix WO₂ WV₂) (x : Fin m → (Fin n → ℝ)) :
    ovOutput beta s WO₁ WV₁ x = ovOutput beta s WO₂ WV₂ x := by
  rw [ovOutput_eq_headOutput, ovOutput_eq_headOutput, h]

/-- The `GL(d)` gauge freedom of the writing side: `(W_O, W_V) ↦ (W_O A, B W_V)`
with `A B = 1` leaves the circuit — hence the head — unchanged. -/
theorem ovMatrix_gauge {A B : Matrix (Fin d) (Fin d) ℝ} (hAB : A * B = 1)
    (WO : Matrix (Fin n) (Fin d) ℝ) (WV : Matrix (Fin d) (Fin n) ℝ) :
    ovMatrix (WO * A) (B * WV) = ovMatrix WO WV := by
  rw [ovMatrix, ovMatrix, Matrix.mul_assoc, ← Matrix.mul_assoc A B WV, hAB, Matrix.one_mul]

theorem ovOutput_gauge (beta : ℝ) (s : Fin m → ℝ) {A B : Matrix (Fin d) (Fin d) ℝ}
    (hAB : A * B = 1) (WO : Matrix (Fin n) (Fin d) ℝ) (WV : Matrix (Fin d) (Fin n) ℝ)
    (x : Fin m → (Fin n → ℝ)) :
    ovOutput beta s (WO * A) (B * WV) x = ovOutput beta s WO WV x :=
  ovOutput_congr_of_ovMatrix_eq beta s (ovMatrix_gauge hAB WO WV) x

/-! ## The writing bottleneck -/

/-- **The OV circuit is low rank.**  Whatever the width `n` of the stream, the map a
head can write has rank at most its head dimension `d`. -/
theorem rank_ovMatrix_le (WO : Matrix (Fin n) (Fin d) ℝ) (WV : Matrix (Fin d) (Fin n) ℝ) :
    (ovMatrix WO WV).rank ≤ d :=
  le_trans (Matrix.rank_mul_le_left _ _) (Matrix.rank_le_width (A := WO))

/-- A head writes only into the column space of its output map. -/
theorem ovOutput_mem_range (beta : ℝ) (s : Fin m → ℝ) (WO : Matrix (Fin n) (Fin d) ℝ)
    (WV : Matrix (Fin d) (Fin n) ℝ) (x : Fin m → (Fin n → ℝ)) :
    ovOutput beta s WO WV x ∈ LinearMap.range (Matrix.mulVecLin WO) :=
  ⟨headOutput beta s (fun j => WV *ᵥ x j), rfl⟩

end BookProof.ChapterAttentionOVCircuit

end
