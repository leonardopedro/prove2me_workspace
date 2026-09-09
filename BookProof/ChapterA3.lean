import Mathlib

/-!
# Chapter A, §A.3 — the concrete `4×4` Majorana / gamma-matrix model

This file builds the concrete Clifford-algebra model of Chapter A §A.3 of
`book.tex` (see `FORMALIZATION_ROADMAP.md`, work-package **N4**): the four
**Majorana matrices** `iγ^μ` (`μ = 0,1,2,3`) as explicit `4×4` complex matrices,
in the real Majorana basis printed at `book.tex` eq. `\label{basis}`, together
with the fifth matrix `iγ⁵`.

To keep the entrywise computations fast and robust, the matrices are defined over
`ℤ` (where the Clifford identities are closed by `decide`) and then cast into `ℂ`
through the ring homomorphism `Int.castRingHom ℂ`; every complex statement is
obtained from the corresponding integer statement by transport along that ring
homomorphism.  The self-contained "infrastructure" the roadmap asks for is:

* `mgamma_clifford` — the defining Clifford relation
  `(iγ^μ)(iγ^ν) + (iγ^ν)(iγ^μ) = -2 η^{μν}` with `η = diag(1,-1,-1,-1)`.
* `mgamma_map_conj` — the matrices are **real** (fixed by entrywise conjugation).
* `mgamma_unitary` — each `iγ^μ` is **unitary** (`(iγ^μ)ᴴ (iγ^μ) = 1`).
* `mgamma5_eq_prod` — `iγ⁵ = iγ⁰ iγ¹ iγ² iγ³`.
* `mgamma5_sq`, `mgamma5_anticomm` — `(iγ⁵)² = -1` and `iγ⁵` anticommutes with
  every `iγ^μ`.
* `dgamma`, `dgamma_clifford` — the Dirac matrices `γ^μ = -i(iγ^μ)` and their
  Clifford relation `γ^μ γ^ν + γ^ν γ^μ = 2 η^{μν}`.

Everything is `sorry`-free and `axiom`-free.  The Pauli fundamental theorem
(Note 36) and Weyl complete reducibility (Note 50), which the later §A.3 results
(Prop 37, Lemma 40, Prop 46, Lemma 52) build on, are `EXTERNAL` and are not
assumed here; only the concrete matrix model is established.
-/

open Matrix

namespace BookProof.ChapterA3

/-! ## Integer model -/

/-- The Minkowski metric `η^{μν} = diag(1, -1, -1, -1)`, over `ℤ`. -/
def minkowskiZ (μ ν : Fin 4) : ℤ := if μ = ν then (if μ = 0 then 1 else -1) else 0

/-- The four Majorana matrices `iγ^μ` over `ℤ`, in the explicit real Majorana
basis of `book.tex` eq. `\label{basis}`. -/
def mgammaZ : Fin 4 → Matrix (Fin 4) (Fin 4) ℤ
  | 0 => !![0,0,1,0; 0,0,0,1; -1,0,0,0; 0,-1,0,0]
  | 1 => !![1,0,0,0; 0,-1,0,0; 0,0,-1,0; 0,0,0,1]
  | 2 => !![0,0,1,0; 0,0,0,1; 1,0,0,0; 0,1,0,0]
  | 3 => !![0,1,0,0; 1,0,0,0; 0,0,0,-1; 0,0,-1,0]

/-- The fifth Majorana matrix `iγ⁵` over `ℤ`. -/
def mgamma5Z : Matrix (Fin 4) (Fin 4) ℤ := !![0,-1,0,0; 1,0,0,0; 0,0,0,1; 0,0,-1,0]

/-- Clifford relation over `ℤ`. -/
theorem mgammaZ_clifford (μ ν : Fin 4) :
    mgammaZ μ * mgammaZ ν + mgammaZ ν * mgammaZ μ =
      (-2 * minkowskiZ μ ν) • (1 : Matrix (Fin 4) (Fin 4) ℤ) := by
  revert μ ν; decide

/-- Orthogonality of the integer Majorana matrices: `(iγ^μ)ᵀ (iγ^μ) = 1`. -/
theorem mgammaZ_transpose_mul (μ : Fin 4) : (mgammaZ μ)ᵀ * mgammaZ μ = 1 := by
  revert μ; decide

/-- `iγ⁵` is the ordered product of the four `iγ^μ`, over `ℤ`. -/
theorem mgamma5Z_eq_prod :
    mgamma5Z = mgammaZ 0 * mgammaZ 1 * mgammaZ 2 * mgammaZ 3 := by decide

/-- `(iγ⁵)² = -1` over `ℤ`. -/
theorem mgamma5Z_sq : mgamma5Z * mgamma5Z = -1 := by decide

/-- `iγ⁵` anticommutes with every `iγ^μ`, over `ℤ`. -/
theorem mgamma5Z_anticomm (μ : Fin 4) :
    mgamma5Z * mgammaZ μ + mgammaZ μ * mgamma5Z = 0 := by revert μ; decide

/-! ## Complex model -/

/-- The Minkowski metric `η^{μν} = diag(1, -1, -1, -1)`. -/
def minkowski (μ ν : Fin 4) : ℂ := (minkowskiZ μ ν : ℂ)

/-- The four **Majorana matrices** `iγ^μ`, `μ = 0,1,2,3`, as `4×4` complex
matrices (the integer model cast into `ℂ`). -/
noncomputable def mgamma (μ : Fin 4) : Matrix (Fin 4) (Fin 4) ℂ :=
  (Int.castRingHom ℂ).mapMatrix (mgammaZ μ)

/-- The fifth Majorana matrix `iγ⁵` as a complex matrix. -/
noncomputable def mgamma5 : Matrix (Fin 4) (Fin 4) ℂ :=
  (Int.castRingHom ℂ).mapMatrix mgamma5Z

/-- **Clifford relation.** `(iγ^μ)(iγ^ν) + (iγ^ν)(iγ^μ) = -2 η^{μν}` where
`η = diag(1,-1,-1,-1)`. -/
theorem mgamma_clifford (μ ν : Fin 4) :
    mgamma μ * mgamma ν + mgamma ν * mgamma μ =
      (-2 * minkowski μ ν) • (1 : Matrix (Fin 4) (Fin 4) ℂ) := by
  have h := congrArg (Int.castRingHom ℂ).mapMatrix (mgammaZ_clifford μ ν)
  rw [map_add, map_mul, map_mul, map_zsmul, map_one] at h
  rw [mgamma, mgamma, h, minkowski]
  ext i j
  simp only [Matrix.smul_apply, Matrix.one_apply, smul_eq_mul, zsmul_eq_mul]
  by_cases hij : i = j <;> simp [hij]

/-- The Majorana matrices are **real**: fixed by entrywise complex conjugation. -/
theorem mgamma_map_conj (μ : Fin 4) :
    (mgamma μ).map (starRingEnd ℂ) = mgamma μ := by
  ext i j
  simp [mgamma, RingHom.mapMatrix_apply, Matrix.map_apply]

/-- Each Majorana matrix is **unitary**: `(iγ^μ)ᴴ (iγ^μ) = 1`. -/
theorem mgamma_unitary (μ : Fin 4) :
    (mgamma μ)ᴴ * mgamma μ = 1 := by
  have hconj : (mgamma μ)ᴴ = (Int.castRingHom ℂ).mapMatrix ((mgammaZ μ)ᵀ) := by
    ext i j
    simp [mgamma, RingHom.mapMatrix_apply, Matrix.map_apply, Matrix.conjTranspose_apply,
      Matrix.transpose_apply]
  rw [hconj, mgamma, ← map_mul, mgammaZ_transpose_mul, map_one]

/-- `iγ⁵` is the ordered product `iγ⁰ iγ¹ iγ² iγ³`. -/
theorem mgamma5_eq_prod :
    mgamma5 = mgamma 0 * mgamma 1 * mgamma 2 * mgamma 3 := by
  rw [mgamma5, mgamma, mgamma, mgamma, mgamma, mgamma5Z_eq_prod, map_mul, map_mul, map_mul]

/-- `(iγ⁵)² = -1`. -/
theorem mgamma5_sq :
    mgamma5 * mgamma5 = -(1 : Matrix (Fin 4) (Fin 4) ℂ) := by
  rw [mgamma5, ← map_mul, mgamma5Z_sq, map_neg, map_one]

/-- `iγ⁵` anticommutes with every `iγ^μ`. -/
theorem mgamma5_anticomm (μ : Fin 4) :
    mgamma5 * mgamma μ + mgamma μ * mgamma5 = 0 := by
  rw [mgamma5, mgamma, ← map_mul, ← map_mul, ← map_add, mgamma5Z_anticomm, map_zero]

/-- The **Dirac matrices** `γ^μ = -i (iγ^μ)` (Def 38). -/
noncomputable def dgamma (μ : Fin 4) : Matrix (Fin 4) (Fin 4) ℂ :=
  (-Complex.I) • mgamma μ

/-- **Clifford relation for the Dirac matrices.**
`γ^μ γ^ν + γ^ν γ^μ = 2 η^{μν}` (note the opposite sign to the Majorana relation,
since `γ^μ = -i (iγ^μ)`). -/
theorem dgamma_clifford (μ ν : Fin 4) :
    dgamma μ * dgamma ν + dgamma ν * dgamma μ =
      (2 * minkowski μ ν) • (1 : Matrix (Fin 4) (Fin 4) ℂ) := by
  simp only [dgamma, Matrix.smul_mul, Matrix.mul_smul, smul_smul]
  rw [← smul_add, neg_mul_neg, Complex.I_mul_I, mgamma_clifford, smul_smul]
  congr 1
  ring

end BookProof.ChapterA3
