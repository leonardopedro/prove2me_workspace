import Mathlib

/-!
# Chapter "On the physical parity transformation and antiparticles" — the complex
structure `J` of canonical quantization and the creation/annihilation split

This file formalizes the finite algebraic core of the subsection *"Majorana spinors in
canonical quantization and antiparticles"* of the `book.tex` chapter *"On the physical
parity transformation and antiparticles"* (`book.tex` line ~7680), continuing
`ChapterParity` / `ChapterParityQL` / `ChapterParityHiggs`.

The book performs the canonical quantization of a **real** Hilbert (or symplectic) space
`V` by introducing a *skew-symmetric* operator `J` with `J² = -1` — a **complex structure**
— and splitting the self-adjoint field `a(v)` into an annihilation and a creation part,

  `a(v) = a(v + iJv) + a(v − iJv)`,

where `a(v + iJv)` is an **annihilation** operator and `a(v − iJv) = a(v + iJv)*` a
**creation** operator.  The two combinations `v ↦ v ± iJv` are (twice) the projections onto
the `∓i`-eigenspaces of `J`; on the complexification the split is governed by the two
spectral projections of the Hermitian involution `iJ`.

On a finite model `V = ℂᵐ` a complex structure is a matrix `J` with `J·J = -1` that is
**skew-adjoint** `Jᴴ = -J` (the complexification of a real skew-symmetric operator).  We
prove, `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`, `Quot.sound`):

* `iJ` (`= i·J`) is a **Hermitian involution**: `iJ_herm` (`(iJ)ᴴ = iJ`) and `iJ_sq`
  (`(iJ)² = 1`), so its eigenvalues are `±1`.
* the annihilation/creation projections `annihProj = ½(1 + iJ)`, `creatProj = ½(1 − iJ)`:
  - `proj_add` : `annihProj + creatProj = 1` (the field split `a(v) = a₋ + a₊`);
  - `annihProj_idem` / `creatProj_idem` : both are idempotent;
  - `annih_creat_zero` / `creat_annih_zero` : `annihProj·creatProj = creatProj·annihProj = 0`
    (complementary projections onto the two eigenspaces);
  - `annihProj_herm` / `creatProj_herm` : both are Hermitian (orthogonal projections);
* `J_unitary` / `J_unitary'` : a compatible complex structure is unitary (`Jᴴ·J = J·Jᴴ = 1`) —
  the metric/complex-structure/symplectic-form compatibility of the book's real Hilbert or
  symplectic space.
* the eigen-relations exhibiting them as the `∓i`-eigenprojections of `J`:
  `J_annih` (`J·annihProj = (−i)·annihProj`) and `J_creat` (`J·creatProj = i·creatProj`) —
  the annihilation combination `v + iJv` lies in the `−i`-eigenspace of `J`, the creation
  combination `v − iJv` in the `+i`-eigenspace.

A concrete non-vacuous witness that the hypotheses are satisfiable is provided by the
standard `2×2` symplectic unit `stdJ = !![0,1;−1,0]` (`stdJ_sq`, `stdJ_skew`).

The surrounding physical modelling (the abstract Clifford/CAR `C*`-algebra, the bosonic
symplectic CCR `[a(v),a(w)] = ⟨v,Jw⟩i`, the vacuum functional) is left as prose, as in the
neighbouring parity files.
-/

open Matrix
open scoped ComplexConjugate

namespace BookProof.ChapterParityMajoranaQuant

variable {m : ℕ}

/-- The Hermitian operator `iJ := i·J` associated with a complex structure `J`. -/
noncomputable def iJ (J : Matrix (Fin m) (Fin m) ℂ) : Matrix (Fin m) (Fin m) ℂ :=
  Complex.I • J

/-- The **annihilation** projection `½(1 + iJ)` — its range is the `−i`-eigenspace of `J`,
spanned by the combinations `v + iJv` the book calls annihilation operators. -/
noncomputable def annihProj (J : Matrix (Fin m) (Fin m) ℂ) : Matrix (Fin m) (Fin m) ℂ :=
  (1 / 2 : ℂ) • (1 + iJ J)

/-- The **creation** projection `½(1 − iJ)` — its range is the `+i`-eigenspace of `J`,
spanned by the combinations `v − iJv` the book calls creation operators. -/
noncomputable def creatProj (J : Matrix (Fin m) (Fin m) ℂ) : Matrix (Fin m) (Fin m) ℂ :=
  (1 / 2 : ℂ) • (1 - iJ J)

section
variable (J : Matrix (Fin m) (Fin m) ℂ)

/-- `iJ` is Hermitian: `(iJ)ᴴ = iJ`, using skew-adjointness `Jᴴ = -J` and `conj i = -i`. -/
theorem iJ_herm (hskew : Jᴴ = -J) : (iJ J)ᴴ = iJ J := by
  unfold iJ
  rw [conjTranspose_smul, hskew, Complex.star_def, Complex.conj_I, smul_neg, neg_smul, neg_neg]

/-- `iJ` is an involution: `(iJ)² = 1`, using `J² = -1`. -/
theorem iJ_sq (hJ2 : J * J = -1) : iJ J * iJ J = 1 := by
  unfold iJ
  rw [smul_mul_smul_comm, hJ2, Complex.I_mul_I, smul_neg, neg_smul, neg_neg, one_smul]

/-- The field split `a(v) = a(v+iJv) + a(v−iJv)`: the two projections sum to the identity. -/
theorem proj_add : annihProj J + creatProj J = 1 := by
  unfold annihProj creatProj
  rw [← smul_add]
  ring_nf
  module

/-- The annihilation projection is idempotent. -/
theorem annihProj_idem (hJ2 : J * J = -1) : annihProj J * annihProj J = annihProj J := by
  unfold annihProj
  have hK := iJ_sq J hJ2
  set K := iJ J
  rw [smul_mul_smul_comm]
  have expand : (1 + K) * (1 + K) = (2 : ℂ) • (1 + K) := by
    have h2 : (1 + K) * (1 + K) = 1 + K + K + K * K := by noncomm_ring
    rw [h2, hK]; module
  rw [expand, smul_smul]; norm_num

/-- The creation projection is idempotent. -/
theorem creatProj_idem (hJ2 : J * J = -1) : creatProj J * creatProj J = creatProj J := by
  unfold creatProj
  have hK := iJ_sq J hJ2
  set K := iJ J
  rw [smul_mul_smul_comm]
  have expand : (1 - K) * (1 - K) = (2 : ℂ) • (1 - K) := by
    have h2 : (1 - K) * (1 - K) = 1 - K - K + K * K := by noncomm_ring
    rw [h2, hK]; module
  rw [expand, smul_smul]; norm_num

/-- The two projections are complementary: `annihProj · creatProj = 0`. -/
theorem annih_creat_zero (hJ2 : J * J = -1) : annihProj J * creatProj J = 0 := by
  unfold annihProj creatProj
  rw [smul_mul_smul_comm]
  have hK := iJ_sq J hJ2
  set K := iJ J
  have h2 : (1 + K) * (1 - K) = 1 - K * K := by noncomm_ring
  rw [h2, hK]; simp

/-- The two projections are complementary: `creatProj · annihProj = 0`. -/
theorem creat_annih_zero (hJ2 : J * J = -1) : creatProj J * annihProj J = 0 := by
  unfold annihProj creatProj
  rw [smul_mul_smul_comm]
  have hK := iJ_sq J hJ2
  set K := iJ J
  have h2 : (1 - K) * (1 + K) = 1 - K * K := by noncomm_ring
  rw [h2, hK]; simp

/-- The annihilation projection is Hermitian (an orthogonal projection). -/
theorem annihProj_herm (hskew : Jᴴ = -J) : (annihProj J)ᴴ = annihProj J := by
  unfold annihProj
  rw [conjTranspose_smul, conjTranspose_add, conjTranspose_one, iJ_herm J hskew,
    Complex.star_def, map_div₀, map_one, Complex.conj_ofNat]

/-- The creation projection is Hermitian (an orthogonal projection). -/
theorem creatProj_herm (hskew : Jᴴ = -J) : (creatProj J)ᴴ = creatProj J := by
  unfold creatProj
  rw [conjTranspose_smul, conjTranspose_sub, conjTranspose_one, iJ_herm J hskew,
    Complex.star_def, map_div₀, map_one, Complex.conj_ofNat]

/-- A compatible complex structure is **unitary**: `Jᴴ · J = 1`.  On a real inner-product
space, a skew-symmetric `J` with `J² = -1` is orthogonal, so it preserves the metric — the
compatibility of the metric, the complex structure and the symplectic form `⟨v,Jw⟩`. -/
theorem J_unitary (hJ2 : J * J = -1) (hskew : Jᴴ = -J) : Jᴴ * J = 1 := by
  rw [hskew, neg_mul, hJ2, neg_neg]

/-- A compatible complex structure is unitary on the other side too: `J · Jᴴ = 1`. -/
theorem J_unitary' (hJ2 : J * J = -1) (hskew : Jᴴ = -J) : J * Jᴴ = 1 := by
  rw [hskew, mul_neg, hJ2, neg_neg]

/-- The annihilation combinations lie in the `−i`-eigenspace of `J`:
`J · annihProj = (−i)·annihProj`. -/
theorem J_annih (hJ2 : J * J = -1) : J * annihProj J = (-Complex.I) • annihProj J := by
  have key : J * (1 + iJ J) = (-Complex.I) • (1 + iJ J) := by
    unfold iJ
    rw [mul_add, mul_one, Matrix.mul_smul, hJ2, smul_add, smul_smul, neg_mul, Complex.I_mul_I]
    module
  unfold annihProj
  rw [Matrix.mul_smul, key, smul_comm]

/-- The creation combinations lie in the `+i`-eigenspace of `J`:
`J · creatProj = i·creatProj`. -/
theorem J_creat (hJ2 : J * J = -1) : J * creatProj J = Complex.I • creatProj J := by
  have key : J * (1 - iJ J) = Complex.I • (1 - iJ J) := by
    unfold iJ
    rw [mul_sub, mul_one, Matrix.mul_smul, hJ2, smul_sub, smul_smul, Complex.I_mul_I]
    module
  unfold creatProj
  rw [Matrix.mul_smul, key, smul_comm]

end

/-! ### A concrete non-vacuous witness: the standard symplectic unit on `ℂ²`. -/

/-- The standard `2×2` symplectic unit `!![0,1;-1,0]`, a real skew-symmetric complex
structure. -/
noncomputable def stdJ : Matrix (Fin 2) (Fin 2) ℂ := !![0, 1; -1, 0]

/-- The standard symplectic unit squares to `-1`. -/
theorem stdJ_sq : stdJ * stdJ = -1 := by
  unfold stdJ; ext i j; fin_cases i <;> fin_cases j <;>
    simp [Matrix.mul_apply, Fin.sum_univ_two]

/-- The standard symplectic unit is skew-adjoint `stdJᴴ = -stdJ` (real skew-symmetric). -/
theorem stdJ_skew : stdJᴴ = -stdJ := by
  unfold stdJ; ext i j; fin_cases i <;> fin_cases j <;>
    simp [Matrix.conjTranspose_apply, Matrix.neg_apply]

end BookProof.ChapterParityMajoranaQuant
