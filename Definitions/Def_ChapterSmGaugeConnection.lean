import Definitions.Def_ChapterYangMillsSU3
import Definitions.Def_ChapterCPTHamiltonian
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterSmDiracYukawa
import Definitions.Def_ChapterSmDiracSpinor
import Definitions.Def_ChapterFarisLavine
import Mathlib


/-!
# The gauge connection inside the covariant derivative `D`

This module closes the second of the honest boundaries left open by the Standard-Model wave
of `CONSOLIDATED_PLAN.md` §D6b-SM: *“the gauge connection inside `D` is not formalized”*.
`BookProof.ChapterSmDiracSpinor` built the spinor Dirac matrix of a plane-wave mode with
`∂_j ↦ i k_j`; what was missing is the **minimal coupling**

```
D_j = ∂_j + i g_s G^a_j T_a + i g W^k_j (τ_k/2) + i g' B_j Y      (book.tex, §“Majorana
                                                                   spinors in the SM”)
```

i.e. the replacement of `i k_j` by `i (k_j + A_j)` with the Lie-algebra-valued connection
`A_j`.  In the collective-coordinate presentation of §D6b-SM.1 the gauge fields *are*
finitely many real numbers `G^a_j, W^k_j, B_j`, so this module works with a constant
background: one plane-wave matter mode, an arbitrary family of Hermitian generators
`T_a` closing with real structure constants, and arbitrary real field components.

## What is proved

* `conn`, `conn_conjTranspose` — the connection `A_j = g Σ_a A^a_j T_a` is Hermitian when the
  generators are.
* `covD`, `covD_conjTranspose` — the covariant derivative `D_j = i (k_j + A_j)` is
  **anti-Hermitian**, which is what makes `−i γ⁰γ·D` symmetric.
* `covD_zero_coupling` — at zero coupling `D_j` is the free `i k_j`: the connection enters
  `D` only through minimal coupling.
* **`covD_commutator`** — the commutator of two covariant derivatives is the **non-abelian
  field strength**:
  `[D_j, D_l] = −i g² Σ_c (Σ_{a,b} f_{abc} A^a_j A^b_l) T_c`,
  the operator form of `W^j_{μν} = −(i/g) tr([D_μ,D_ν] τ^j)` of `book.tex` and of the
  `g_s f^{abc} G^b_j G^c_k` term of the magnetic energy `B^G` of §D6b-SM.1;
  `covD_commutator_abelian` is its abelian case (a constant abelian background is pure
  gauge: the commutator vanishes).
* **Gauge covariance** — `covD_conj` (conjugating `D` by a unitary conjugates the
  connection) and `conn_gauge_transform` (if the adjoint action of `U` rotates the
  generators by a real matrix `R`, the conjugated connection is again a connection, with
  rotated field components): the space of connections is stable under gauge
  transformations, and `D` transforms covariantly.
* **The gauged Dirac matrix** `diracGaugeMat` — the Hermitian one-particle Dirac matrix on
  `spinor ⊗ internal` with the connection inside `D`
  (`diracGaugeMat_conjTranspose`), which reduces to the free matrix of
  `BookProof.ChapterSmDiracSpinor` at zero field (`diracGaugeMat_free`) and splits as
  free + gauge interaction (`diracGaugeMat_split`).
* **Second quantization** — `diracGaugeField` puts the gauged Dirac matrix on the CAR
  algebra of `BookProof.ChapterSmCarAlgebra` (`4 × 3 = 12` colour–spinor modes),
  `diracGaugeField_symmetric`, and `dirac_gauge_field_esa`: essential self-adjointness
  through the Faris–Lavine hypotheses of `BookProof.ChapterSmDiracYukawa`.

## Honest boundary

The background is constant (one plane-wave matter mode, collective gauge coordinates), so
`D_j` carries `i k_j` rather than an unbounded derivative, and this module’s commutator
`[D_j, D_l]` sees only the non-abelian part of `F` — the `∂_j A_l − ∂_l A_j` term vanishes
because the field is constant by construction (the full `F = ∂A − ∂A + [A,A]` is the
magnetic energy `B^G`/`B^W`/`B^B` of `ChapterSmHamiltonian`).  No dynamics of the gauge
field and no continuum limit of `D` is claimed here.  (The curl/continuum half is reachable
by the momentum-space convolution already used for NS and QG — `fourier_mul_eq_convolution`
/ `fourier_advection_convolution` — not a QYM device, only for proofs of this type.)

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.SmGaugeConnection

open Matrix Kronecker
open BookProof.YangMillsSU3 BookProof.ChapterCPTHamiltonian BookProof.SmCar
open BookProof.SmDiracYukawa BookProof.SmDiracSpinor BookProof.FarisLavine

noncomputable section

variable {N d : ℕ}

/-! ## 1. The connection -/

/-- **The gauge connection** `A_j = g Σ_a A^a_j T_a`: the Lie-algebra-valued one-form built
from the real collective coordinates `A^a_j` of §D6b-SM.1 and the generators `T_a`. -/
def conn (g : ℝ) (T : Fin d → Matrix (Fin N) (Fin N) ℂ) (A : Fin d → Fin 3 → ℝ)
    (j : Fin 3) : Matrix (Fin N) (Fin N) ℂ :=
  ∑ a : Fin d, ((g * A a j : ℝ) : ℂ) • T a



/-- At zero coupling the connection vanishes. -/
@[simp] theorem conn_zero_coupling (T : Fin d → Matrix (Fin N) (Fin N) ℂ)
    (A : Fin d → Fin 3 → ℝ) (j : Fin 3) : conn 0 T A j = 0 := by
  simp [conn]

/-- At zero field the connection vanishes. -/
@[simp] theorem conn_zero_field (g : ℝ) (T : Fin d → Matrix (Fin N) (Fin N) ℂ) (j : Fin 3) :
    conn g T (fun _ _ => (0 : ℝ)) j = 0 := by
  simp [conn]

/-! ## 2. The covariant derivative -/

/-- **The covariant derivative of a plane-wave mode**, `D_j = i (k_j + A_j)`: the free
`∂_j ↦ i k_j` with the connection inside it (minimal coupling). -/
def covD (k : Fin 3 → ℝ) (g : ℝ) (T : Fin d → Matrix (Fin N) (Fin N) ℂ)
    (A : Fin d → Fin 3 → ℝ) (j : Fin 3) : Matrix (Fin N) (Fin N) ℂ :=
  Complex.I • (((k j : ℝ) : ℂ) • (1 : Matrix (Fin N) (Fin N) ℂ) + conn g T A j)













/-! ## 3. Gauge covariance -/





/-! ## 4. The gauged Dirac matrix -/



/-- **The Dirac one-particle matrix with the gauge connection inside `D`**: the Hermitian
matrix `γ⁰γ·(−iD) + masses` on `spinor ⊗ internal`, with `−i D_j = k_j + A_j`. -/
def diracGaugeMat (k : Fin 3 → ℝ) (m1 m2 : ℝ) (g : ℝ) (T : Fin d → Matrix (Fin N) (Fin N) ℂ)
    (A : Fin d → Fin 3 → ℝ) : Matrix (Fin 4 × Fin N) (Fin 4 × Fin N) ℂ :=
  (∑ j : Fin 3, Kin j ⊗ₖ (((k j : ℝ) : ℂ) • (1 : Matrix (Fin N) (Fin N) ℂ) + conn g T A j))
    + (((-Complex.I) * (m1 : ℂ)) • MassA + ((-Complex.I) * (m2 : ℂ)) • MassB)
        ⊗ₖ (1 : Matrix (Fin N) (Fin N) ℂ)







/-! ## 5. Second quantization on the CAR algebra -/

/-- The colour–spinor mode labelling: the `4 × 3 = 12` modes of one quark flavour at one
plane-wave momentum. -/
def modeEquiv : Fin 4 × Fin 3 ≃ Fin 12 := finProdFinEquiv

/-- **The gauged Dirac field operator**: the second quantization `Σ_{AB} H_{AB} a†_A a_B` of
the gauged Dirac matrix on the CAR algebra of the twelve colour–spinor modes. -/
def diracGaugeField (k : Fin 3 → ℝ) (m1 m2 : ℝ) (g : ℝ) (T : Fin 8 → Matrix (Fin 3) (Fin 3) ℂ)
    (A : Fin 8 → Fin 3 → ℝ) : FermiFock 12 →ₗ[ℂ] FermiFock 12 :=
  fermiBilin (Matrix.reindex modeEquiv modeEquiv (diracGaugeMat k m1 m2 g T A))CONSOLIDATED_PLAN.md` §D6b-SM: *“the gauge connection inside `D` is not formalized”*.
`BookProof.ChapterSmDiracSpinor` built the spinor Dirac matrix of a plane-wave mode with
`∂_j ↦ i k_j`; what was missing is the **minimal coupling**

```
D_j = ∂_j + i g_s G^a_j T_a + i g W^k_j (τ_k/2) + i g' B_j Y      (book.tex, §“Majorana
                                                                   spinors in the SM”)
```

i.e. the replacement of `i k_j` by `i (k_j + A_j)` with the Lie-algebra-valued connection
`A_j`.  In the collective-coordinate presentation of §D6b-SM.1 the gauge fields *are*
finitely many real numbers `G^a_j, W^k_j, B_j`, so this module works with a constant
background: one plane-wave matter mode, an arbitrary family of Hermitian generators
`T_a` closing with real structure constants, and arbitrary real field components.

## What is proved

* `conn`, `conn_conjTranspose` — the connection `A_j = g Σ_a A^a_j T_a` is Hermitian when the
  generators are.
* `covD`, `covD_conjTranspose` — the covariant derivative `D_j = i (k_j + A_j)` is
  **anti-Hermitian**, which is what makes `−i γ⁰γ·D` symmetric.
* `covD_zero_coupling` — at zero coupling `D_j` is the free `i k_j`: the connection enters
  `D` only through minimal coupling.
* **`covD_commutator`** — the commutator of two covariant derivatives is the **non-abelian
  field strength**:
  `[D_j, D_l] = −i g² Σ_c (Σ_{a,b} f_{abc} A^a_j A^b_l) T_c`,
  the operator form of `W^j_{μν} = −(i/g) tr([D_μ,D_ν] τ^j)` of `book.tex` and of the
  `g_s f^{abc} G^b_j G^c_k` term of the magnetic energy `B^G` of §D6b-SM.1;
  `covD_commutator_abelian` is its abelian case (a constant abelian background is pure
  gauge: the commutator vanishes).
* **Gauge covariance** — `covD_conj` (conjugating `D` by a unitary conjugates the
  connection) and `conn_gauge_transform` (if the adjoint action of `U` rotates the
  generators by a real matrix `R`, the conjugated connection is again a connection, with
  rotated field components): the space of connections is stable under gauge
  transformations, and `D` transforms covariantly.
* **The gauged Dirac matrix** `diracGaugeMat` — the Hermitian one-particle Dirac matrix on
  `spinor ⊗ internal` with the connection inside `D`
  (`diracGaugeMat_conjTranspose`), which reduces to the free matrix of
  `BookProof.ChapterSmDiracSpinor` at zero field (`diracGaugeMat_free`) and splits as
  free + gauge interaction (`diracGaugeMat_split`).
* **Second quantization** — `diracGaugeField` puts the gauged Dirac matrix on the CAR
  algebra of `BookProof.ChapterSmCarAlgebra` (`4 × 3 = 12` colour–spinor modes),
  `diracGaugeField_symmetric`, and `dirac_gauge_field_esa`: essential self-adjointness
  through the Faris–Lavine hypotheses of `BookProof.ChapterSmDiracYukawa`.

## Honest boundary

The background is constant (one plane-wave matter mode, collective gauge coordinates), so
`D_j` carries `i k_j` rather than an unbounded derivative, and this module’s commutator
`[D_j, D_l]` sees only the non-abelian part of `F` — the `∂_j A_l − ∂_l A_j` term vanishes
because the field is constant by construction (the full `F = ∂A − ∂A + [A,A]` is the
magnetic energy `B^G`/`B^W`/`B^B` of `ChapterSmHamiltonian`).  No dynamics of the gauge
field and no continuum limit of `D` is claimed here.  (The curl/continuum half is reachable
by the momentum-space convolution already used for NS and QG — `fourier_mul_eq_convolution`
/ `fourier_advection_convolution` — not a QYM device, only for proofs of this type.)

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.SmGaugeConnection

open Matrix Kronecker
open BookProof.YangMillsSU3 BookProof.ChapterCPTHamiltonian BookProof.SmCar
open BookProof.SmDiracYukawa BookProof.SmDiracSpinor BookProof.FarisLavine

noncomputable section

variable {N d : ℕ}

/-! ## 1. The connection -/

/-- **The gauge connection** `A_j = g Σ_a A^a_j T_a`: the Lie-algebra-valued one-form built
from the real collective coordinates `A^a_j` of §D6b-SM.1 and the generators `T_a`. -/
def conn (g : ℝ) (T : Fin d → Matrix (Fin N) (Fin N) ℂ) (A : Fin d → Fin 3 → ℝ)
    (j : Fin 3) : Matrix (Fin N) (Fin N) ℂ :=
  ∑ a : Fin d, ((g * A a j : ℝ) : ℂ) • T a

/-- **The connection is Hermitian** when the generators are. -/
theorem conn_conjTranspose {g : ℝ} {T : Fin d → Matrix (Fin N) (Fin N) ℂ}
    {A : Fin d → Fin 3 → ℝ} (hT : ∀ a, (T a)ᴴ = T a) (j : Fin 3) :
    (conn g T A j)ᴴ = conn g T A j := by
  rw [conn, Matrix.conjTranspose_sum]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [Matrix.conjTranspose_smul, hT a, Complex.star_def, Complex.conj_ofReal]

/-- At zero coupling the connection vanishes. -/
@[simp] theorem conn_zero_coupling (T : Fin d → Matrix (Fin N) (Fin N) ℂ)
    (A : Fin d → Fin 3 → ℝ) (j : Fin 3) : conn 0 T A j = 0 := by
  simp [conn]

/-- At zero field the connection vanishes. -/
@[simp] theorem conn_zero_field (g : ℝ) (T : Fin d → Matrix (Fin N) (Fin N) ℂ) (j : Fin 3) :
    conn g T (fun _ _ => (0 : ℝ)) j = 0 := by
  simp [conn]

/-! ## 2. The covariant derivative -/

/-- **The covariant derivative of a plane-wave mode**, `D_j = i (k_j + A_j)`: the free
`∂_j ↦ i k_j` with the connection inside it (minimal coupling). -/
def covD (k : Fin 3 → ℝ) (g : ℝ) (T : Fin d → Matrix (Fin N) (Fin N) ℂ)
    (A : Fin d → Fin 3 → ℝ) (j : Fin 3) : Matrix (Fin N) (Fin N) ℂ :=
  Complex.I • (((k j : ℝ) : ℂ) • (1 : Matrix (Fin N) (Fin N) ℂ) + conn g T A j)

/-- **The covariant derivative is anti-Hermitian**, exactly as `∂_j` is. -/
theorem covD_conjTranspose {k : Fin 3 → ℝ} {g : ℝ} {T : Fin d → Matrix (Fin N) (Fin N) ℂ}
    {A : Fin d → Fin 3 → ℝ} (hT : ∀ a, (T a)ᴴ = T a) (j : Fin 3) :
    (covD k g T A j)ᴴ = -covD k g T A j := by
  rw [covD, Matrix.conjTranspose_smul, Matrix.conjTranspose_add, Matrix.conjTranspose_smul,
    conn_conjTranspose hT, Matrix.conjTranspose_one]
  have hI : star Complex.I = -Complex.I := by simp
  rw [hI, Complex.star_def, Complex.conj_ofReal, neg_smul]

/-- **At zero coupling the covariant derivative is the free derivative** `i k_j`: the gauge
fields enter `D` only through the connection. -/
theorem covD_zero_coupling (k : Fin 3 → ℝ) (T : Fin d → Matrix (Fin N) (Fin N) ℂ)
    (A : Fin d → Fin 3 → ℝ) (j : Fin 3) :
    covD k 0 T A j = (Complex.I * ((k j : ℝ) : ℂ)) • (1 : Matrix (Fin N) (Fin N) ℂ) := by
  rw [covD, conn_zero_coupling, add_zero, smul_smul]

/-- A reorganization of a doubly indexed sum of Lie-algebra elements. -/
theorem sum_smul_reorg (x : Fin d → Fin d → ℂ) (y : Fin d → Fin d → Fin d → ℂ)
    (T : Fin d → Matrix (Fin N) (Fin N) ℂ) :
    ∑ a : Fin d, ∑ b : Fin d, x a b • (Complex.I • ∑ c : Fin d, y a b c • T c)
      = ∑ c : Fin d, (∑ a : Fin d, ∑ b : Fin d, Complex.I * (x a b * y a b c)) • T c := by
  have hterm : ∀ a b c : Fin d,
      x a b • (Complex.I • (y a b c • T c)) = (Complex.I * (x a b * y a b c)) • T c := by
    intro a b c
    rw [smul_smul, smul_smul]
    congr 1
    ring
  have hleft : ∀ a b : Fin d, x a b • (Complex.I • ∑ c : Fin d, y a b c • T c)
      = ∑ c : Fin d, (Complex.I * (x a b * y a b c)) • T c := by
    intro a b
    rw [Finset.smul_sum, Finset.smul_sum]
    exact Finset.sum_congr rfl fun c _ => hterm a b c
  calc ∑ a : Fin d, ∑ b : Fin d, x a b • (Complex.I • ∑ c : Fin d, y a b c • T c)
      = ∑ a : Fin d, ∑ b : Fin d, ∑ c : Fin d, (Complex.I * (x a b * y a b c)) • T c := by
        exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => hleft a b
    _ = ∑ a : Fin d, ∑ c : Fin d, ∑ b : Fin d, (Complex.I * (x a b * y a b c)) • T c := by
        exact Finset.sum_congr rfl fun a _ => Finset.sum_comm
    _ = ∑ c : Fin d, ∑ a : Fin d, ∑ b : Fin d, (Complex.I * (x a b * y a b c)) • T c :=
        Finset.sum_comm
    _ = ∑ c : Fin d, (∑ a : Fin d, ∑ b : Fin d, Complex.I * (x a b * y a b c)) • T c := by
        refine Finset.sum_congr rfl fun c _ => ?_
        rw [Finset.sum_smul]
        exact Finset.sum_congr rfl fun a _ => (Finset.sum_smul ..).symm

/-- **The commutator of two connections** is the non-abelian term of the field strength. -/
theorem conn_commutator {g : ℝ} {T : Fin d → Matrix (Fin N) (Fin N) ℂ}
    {f : Fin d → Fin d → Fin d → ℝ} (hf : ClosesWithStructureConstants T f)
    (A : Fin d → Fin 3 → ℝ) (j l : Fin 3) :
    conn g T A j * conn g T A l - conn g T A l * conn g T A j
      = ∑ c : Fin d,
          (Complex.I * ((g : ℂ) ^ 2)
            * ((∑ a : Fin d, ∑ b : Fin d, f a b c * A a j * A b l : ℝ) : ℂ)) • T c := by
  have hprod : ∀ p q : Fin 3, conn g T A p * conn g T A q
      = ∑ a : Fin d, ∑ b : Fin d,
          (((g * A a p : ℝ) : ℂ) * ((g * A b q : ℝ) : ℂ)) • (T a * T b) := by
    intro p q
    rw [conn, conn, Finset.sum_mul]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [Matrix.smul_mul, Finset.mul_sum, Finset.smul_sum]
    exact Finset.sum_congr rfl fun b _ => by rw [Matrix.mul_smul, smul_smul]
  rw [hprod, hprod]
  have hswap : ∑ a : Fin d, ∑ b : Fin d,
        (((g * A a l : ℝ) : ℂ) * ((g * A b j : ℝ) : ℂ)) • (T a * T b)
      = ∑ a : Fin d, ∑ b : Fin d,
        (((g * A a j : ℝ) : ℂ) * ((g * A b l : ℝ) : ℂ)) • (T b * T a) := by
    rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => by
      rw [mul_comm (((g * A b l : ℝ) : ℂ))]
  rw [hswap, ← Finset.sum_sub_distrib]
  have hterm : ∀ a : Fin d, (∑ b : Fin d,
        (((g * A a j : ℝ) : ℂ) * ((g * A b l : ℝ) : ℂ)) • (T a * T b)
      - ∑ b : Fin d, (((g * A a j : ℝ) : ℂ) * ((g * A b l : ℝ) : ℂ)) • (T b * T a))
      = ∑ b : Fin d, (((g * A a j : ℝ) : ℂ) * ((g * A b l : ℝ) : ℂ)) •
          (Complex.I • ∑ c : Fin d, ((f a b c : ℝ) : ℂ) • T c) := by
    intro a
    rw [← Finset.sum_sub_distrib]
    exact Finset.sum_congr rfl fun b _ => by rw [← smul_sub, hf a b]
  rw [Finset.sum_congr rfl fun a (_ : a ∈ Finset.univ) => hterm a]
  rw [sum_smul_reorg (fun a b => ((g * A a j : ℝ) : ℂ) * ((g * A b l : ℝ) : ℂ))
    (fun a b c => ((f a b c : ℝ) : ℂ)) T]
  refine Finset.sum_congr rfl fun c _ => ?_
  congr 1
  push_cast
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [Finset.mul_sum]
  exact Finset.sum_congr rfl fun b _ => by ring

/-- **The commutator of two covariant derivatives is the non-abelian field strength.**  For
a constant background the derivative terms `∂_j A_l − ∂_l A_j` are absent and what remains
is precisely the `g f^{abc} A^a_j A^b_l` term of the magnetic energy of §D6b-SM.1 — the
operator form of `W^j_{μν} = −(i/g) tr([D_μ,D_ν] τ^j)` of `book.tex`. -/
theorem covD_commutator {k : Fin 3 → ℝ} {g : ℝ} {T : Fin d → Matrix (Fin N) (Fin N) ℂ}
    {f : Fin d → Fin d → Fin d → ℝ} (hf : ClosesWithStructureConstants T f)
    (A : Fin d → Fin 3 → ℝ) (j l : Fin 3) :
    covD k g T A j * covD k g T A l - covD k g T A l * covD k g T A j
      = ∑ c : Fin d,
          (-Complex.I * ((g : ℂ) ^ 2)
            * ((∑ a : Fin d, ∑ b : Fin d, f a b c * A a j * A b l : ℝ) : ℂ)) • T c := by
  have hexp : covD k g T A j * covD k g T A l - covD k g T A l * covD k g T A j
      = -(conn g T A j * conn g T A l - conn g T A l * conn g T A j) := by
    simp only [covD, Matrix.smul_mul, Matrix.mul_smul, smul_smul, Complex.I_mul_I,
      Matrix.add_mul, Matrix.mul_add, Matrix.one_mul, Matrix.mul_one, smul_add, neg_smul,
      one_smul, mul_comm]
    abel
  rw [hexp, conn_commutator hf A j l, ← Finset.sum_neg_distrib]
  exact Finset.sum_congr rfl fun c _ => by rw [← neg_smul]; congr 1; ring

/-- **An abelian constant background has no field strength**: with vanishing structure
constants the covariant derivatives commute. -/
theorem covD_commutator_abelian {k : Fin 3 → ℝ} {g : ℝ} {T : Fin d → Matrix (Fin N) (Fin N) ℂ}
    (hf : ClosesWithStructureConstants T (fun _ _ _ => (0 : ℝ)))
    (A : Fin d → Fin 3 → ℝ) (j l : Fin 3) :
    covD k g T A j * covD k g T A l - covD k g T A l * covD k g T A j = 0 := by
  rw [covD_commutator hf A j l]
  simp

/-! ## 3. Gauge covariance -/

/-- **Gauge covariance of `D`**: conjugating the covariant derivative by a unitary
conjugates the connection and leaves the momentum term alone. -/
theorem covD_conj {k : Fin 3 → ℝ} {g : ℝ} {T : Fin d → Matrix (Fin N) (Fin N) ℂ}
    {A : Fin d → Fin 3 → ℝ} {U : Matrix (Fin N) (Fin N) ℂ} (hU : U * Uᴴ = 1) (j : Fin 3) :
    U * covD k g T A j * Uᴴ
      = Complex.I • (((k j : ℝ) : ℂ) • (1 : Matrix (Fin N) (Fin N) ℂ)
          + U * conn g T A j * Uᴴ) := by
  rw [covD, Matrix.mul_smul, Matrix.smul_mul]
  congr 1
  rw [Matrix.mul_add, Matrix.add_mul, Matrix.mul_smul, Matrix.smul_mul, Matrix.mul_one, hU]

/-- **The space of connections is gauge stable**: if the adjoint action of `U` rotates the
generators by the real matrix `R`, then the conjugated connection is again a connection,
with the field components rotated by `R`. -/
theorem conn_gauge_transform {g : ℝ} {T : Fin d → Matrix (Fin N) (Fin N) ℂ}
    {A : Fin d → Fin 3 → ℝ} {U : Matrix (Fin N) (Fin N) ℂ} {R : Fin d → Fin d → ℝ}
    (hUT : ∀ a, U * T a * Uᴴ = ∑ b : Fin d, ((R a b : ℝ) : ℂ) • T b) (j : Fin 3) :
    U * conn g T A j * Uᴴ = conn g T (fun b i => ∑ a : Fin d, R a b * A a i) j := by
  have h1 : U * conn g T A j * Uᴴ
      = ∑ a : Fin d, ((g * A a j : ℝ) : ℂ) • (U * T a * Uᴴ) := by
    rw [conn, Matrix.mul_sum, Matrix.sum_mul]
    exact Finset.sum_congr rfl fun a _ => by rw [Matrix.mul_smul, Matrix.smul_mul]
  rw [h1]
  simp only [hUT, Finset.smul_sum, smul_smul]
  rw [Finset.sum_comm, conn]
  refine Finset.sum_congr rfl fun b _ => ?_
  rw [← Finset.sum_smul]
  congr 1
  push_cast
  rw [Finset.mul_sum]
  exact Finset.sum_congr rfl fun a _ => by ring

/-! ## 4. The gauged Dirac matrix -/

/-- The Kronecker product distributes over a finite sum in its left factor. -/
theorem sum_kronecker_right {n : ℕ} (F : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ)
    (B : Matrix (Fin n) (Fin n) ℂ) : (∑ j : Fin 3, F j) ⊗ₖ B = ∑ j : Fin 3, (F j) ⊗ₖ B := by
  classical
  induction (Finset.univ : Finset (Fin 3)) using Finset.induction with
  | empty => simp
  | insert a s ha ih => rw [Finset.sum_insert ha, Finset.sum_insert ha, Matrix.add_kronecker, ih]

/-- **The Dirac one-particle matrix with the gauge connection inside `D`**: the Hermitian
matrix `γ⁰γ·(−iD) + masses` on `spinor ⊗ internal`, with `−i D_j = k_j + A_j`. -/
def diracGaugeMat (k : Fin 3 → ℝ) (m1 m2 : ℝ) (g : ℝ) (T : Fin d → Matrix (Fin N) (Fin N) ℂ)
    (A : Fin d → Fin 3 → ℝ) : Matrix (Fin 4 × Fin N) (Fin 4 × Fin N) ℂ :=
  (∑ j : Fin 3, Kin j ⊗ₖ (((k j : ℝ) : ℂ) • (1 : Matrix (Fin N) (Fin N) ℂ) + conn g T A j))
    + (((-Complex.I) * (m1 : ℂ)) • MassA + ((-Complex.I) * (m2 : ℂ)) • MassB)
        ⊗ₖ (1 : Matrix (Fin N) (Fin N) ℂ)

/-- **The gauged Dirac matrix is Hermitian**, hence a legitimate one-particle input to the
fermionic machinery. -/
theorem diracGaugeMat_conjTranspose {k : Fin 3 → ℝ} {m1 m2 g : ℝ}
    {T : Fin d → Matrix (Fin N) (Fin N) ℂ} {A : Fin d → Fin 3 → ℝ} (hT : ∀ a, (T a)ᴴ = T a) :
    (diracGaugeMat k m1 m2 g T A)ᴴ = diracGaugeMat k m1 m2 g T A := by
  rw [diracGaugeMat, Matrix.conjTranspose_add, Matrix.conjTranspose_sum]
  congr 1
  · refine Finset.sum_congr rfl fun j _ => ?_
    rw [Matrix.conjTranspose_kronecker, Kin_conjTranspose, Matrix.conjTranspose_add,
      Matrix.conjTranspose_smul, Matrix.conjTranspose_one, conn_conjTranspose hT,
      Complex.star_def, Complex.conj_ofReal]
  · rw [Matrix.conjTranspose_kronecker, Matrix.conjTranspose_one, Matrix.conjTranspose_add,
      Matrix.conjTranspose_smul, Matrix.conjTranspose_smul, MassA_conjTranspose,
      MassB_conjTranspose]
    have h1 : star ((-Complex.I) * (m1 : ℂ)) = Complex.I * (m1 : ℂ) := by
      simp [mul_comm]
    have h2 : star ((-Complex.I) * (m2 : ℂ)) = Complex.I * (m2 : ℂ) := by
      simp [mul_comm]
    rw [h1, h2, smul_neg, smul_neg, ← neg_smul, ← neg_smul]
    congr 2 <;> ring

/-- **Minimal coupling**: the gauged Dirac matrix splits as the free Dirac matrix (tensored
with the internal identity) plus the gauge interaction `Σ_j γ⁰γ^j ⊗ A_j`. -/
theorem diracGaugeMat_split (k : Fin 3 → ℝ) (m1 m2 g : ℝ)
    (T : Fin d → Matrix (Fin N) (Fin N) ℂ) (A : Fin d → Fin 3 → ℝ) :
    diracGaugeMat k m1 m2 g T A
      = diracOneParticle k m1 m2 ⊗ₖ (1 : Matrix (Fin N) (Fin N) ℂ)
        + ∑ j : Fin 3, Kin j ⊗ₖ conn g T A j := by
  have hfree : diracOneParticle k m1 m2
      = (∑ j : Fin 3, ((k j : ℝ) : ℂ) • Kin j)
        + (((-Complex.I) * (m1 : ℂ)) • MassA + ((-Complex.I) * (m2 : ℂ)) • MassB) := by
    rw [diracOneParticle, diracHamOp, smul_add, smul_add, smul_smul, smul_smul, smul_smul]
    have hII : (-Complex.I) * Complex.I = 1 := by
      rw [neg_mul, Complex.I_mul_I, neg_neg]
    rw [hII, one_smul, add_assoc]
  rw [diracGaugeMat, hfree]
  simp only [Matrix.add_kronecker, sum_kronecker_right, Matrix.kronecker_add,
    Matrix.kronecker_smul, Matrix.smul_kronecker, Finset.sum_add_distrib]
  abel

/-- **At zero field the gauged Dirac matrix is the free one** of
`BookProof.ChapterSmDiracSpinor`. -/
theorem diracGaugeMat_free (k : Fin 3 → ℝ) (m1 m2 g : ℝ)
    (T : Fin d → Matrix (Fin N) (Fin N) ℂ) :
    diracGaugeMat k m1 m2 g T (fun _ _ => (0 : ℝ))
      = diracOneParticle k m1 m2 ⊗ₖ (1 : Matrix (Fin N) (Fin N) ℂ) := by
  rw [diracGaugeMat_split]
  simp

/-! ## 5. Second quantization on the CAR algebra -/

/-- The colour–spinor mode labelling: the `4 × 3 = 12` modes of one quark flavour at one
plane-wave momentum. -/
def modeEquiv : Fin 4 × Fin 3 ≃ Fin 12 := finProdFinEquiv

/-- **The gauged Dirac field operator**: the second quantization `Σ_{AB} H_{AB} a†_A a_B` of
the gauged Dirac matrix on the CAR algebra of the twelve colour–spinor modes. -/
def diracGaugeField (k : Fin 3 → ℝ) (m1 m2 : ℝ) (g : ℝ) (T : Fin 8 → Matrix (Fin 3) (Fin 3) ℂ)
    (A : Fin 8 → Fin 3 → ℝ) : FermiFock 12 →ₗ[ℂ] FermiFock 12 :=
  fermiBilin (Matrix.reindex modeEquiv modeEquiv (diracGaugeMat k m1 m2 g T A))



/-- **The gauged Dirac field operator is essentially self-adjoint**, through the three
Faris–Lavine hypotheses of `BookProof.ChapterSmDiracYukawa` with the comparison operator
`N = Σ_A ω_A a†_A a_A + c₀`. -/
theorem dirac_gauge_field_esa {k : Fin 3 → ℝ} {m1 m2 g : ℝ}
    {T : Fin 8 → Matrix (Fin 3) (Fin 3) ℂ} {A : Fin 8 → Fin 3 → ℝ} (hT : ∀ a, (T a)ᴴ = T a)
    {om : Fin 12 → ℝ} {c0 : ℝ} (hom : ∀ i, 0 ≤ om i) (hc0 : 1 ≤ c0) :
    EssentiallySelfAdjointOn (fullDom 12)
      ((onFull (smFermiHam (Matrix.reindex modeEquiv modeEquiv (diracGaugeMat k m1 m2 g T A))
          (0 : Matrix (Fin 12) (Fin 12) ℂ) 0)).comp
        (Submodule.inclusion (le_refl (fullDom 12)))) :=
  sm_fermi_esa (om := om) (c0 := c0)
    (by rw [Matrix.conjTranspose_reindex, diracGaugeMat_conjTranspose hT]) hom hc0

end

end BookProof.SmGaugeConnection
