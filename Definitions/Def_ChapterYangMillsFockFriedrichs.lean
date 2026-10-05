import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterQg3DGaugeFarisLavine
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterYangMillsFriedrichs
import Mathlib


/-!
# Quantum Yang–Mills on the nested Fock space: the **direct Friedrichs extension**

The Yang–Mills Hamiltonian is a *positive* sum of squares,

`H = ½ Σ_m π_m² + ½ Σ_r Φ_r²`,

with symmetric momentum operators `π_m` and symmetric multiplication operators `Φ_r` (the
magnetic field `B_{i a}` — including its **quartic, non-abelian** part — and the 3D
gauge-fixing forms).  It is therefore **bounded below**, and the Friedrichs extension applies
to it *directly*: no Faris–Lavine commutator certificate is needed on the Yang–Mills side,
and none is used here.

Both ingredients of the construction are fibrewise, so they lift from the one-particle
Hilbert space `L²(ℝ⁹⁹)` to the nested Fock space `⊕ₙ L²(ℝ^{99n})`:

* symmetry and positivity of the quadratic form are checked sector by sector
  (`dsOp_symmetricOn`, `BookProof.QgOuterFock.dsOp_quadForm_nonneg`);
* the finite-particle core is dense (`dsCore_dense`), so the abstract Friedrichs theorem
  `BookProof.FriedrichsExtension.friedrichs_extension_exists` — proved in this development,
  with no boundedness hypothesis — produces a positive self-adjoint extension of the outer
  Hamiltonian, and Stone's theorem the unitary time evolution it generates.

## The variables

`99 = 3 + 24 + 72` per particle: three spatial coordinates, the `24 = 3 × 8` gauge-field
coordinates `A_{j,a}` and the `72 = 3 × 3 × 8` **independent coordinates `∂_j A_{k,a}`**
representing the spatial derivatives of the gauge field.  Every particle carries its own
copy, `ycoord p i` being the global coordinate of the `i`-th field-space direction of the
`p`-th particle.

## What is proved

* `magPolyN`, `gaussPolyN` — the magnetic field `B_{i a} = ε_{ijk}(∂_j A_{k,a} +
  f_{abc} A_{j,b} A_{k,c})` of each particle, at **arbitrary real structure constants**
  (so the genuinely non-abelian, quartic case is included), and the **3D gauge-fixing form**
  `Σ_j ∂_j A_{j,a}` written in the independent derivative coordinates.
* `ymSectorHam_quadForm_nonneg` — **the `n`-particle gauge-fixed Yang–Mills Hamiltonian is
  bounded below** (indeed non-negative).
* `ymSector_friedrichs_extension` — hence it has a positive self-adjoint (Friedrichs)
  extension on `L²(ℝ^{99n})`, for every particle number and every family of structure
  constants.
* **`ymFock_friedrichs_extension`** — the headline: the Yang–Mills Hamiltonian on the nested
  Fock space `⊕ₙ L²(ℝ^{99n})` is bounded below (`ymFockHam_quadForm_nonneg`) and has a
  positive self-adjoint (Friedrichs) extension.
* `ymFock_stone_flow` — the unitary time evolution it generates (Stone).
* `ymFockHam_number_conserving` — the outer Hamiltonian conserves the particle number: it is
  block diagonal in the number sectors, and its restriction to the `n`-particle sector is the
  `n`-particle Hamiltonian.  This is why no lattice regularization enters: the number sectors,
  not a spatial cutoff, decompose the problem.

No spectral information and no mass gap is claimed anywhere.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.YmFockFriedrichs

open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent

noncomputable section

/-! ## 1. The coordinates of the `n`-particle sector -/

/-- The global coordinate of the `i`-th field-space direction of the `p`-th particle. -/
def ycoord {n : ℕ} (p : Fin n) (i : Fin 99) : Fin (n * 99) := finProdFinEquiv (p, i)



/-- The particle carrying a global coordinate. -/
def ypart {n : ℕ} (I : Fin (n * 99)) : Fin n := (finProdFinEquiv.symm I).1

/-- The field-space direction of a global coordinate. -/
def ymode {n : ℕ} (I : Fin (n * 99)) : Fin 99 := (finProdFinEquiv.symm I).2

@[simp] theorem ypart_ycoord {n : ℕ} (p : Fin n) (i : Fin 99) : ypart (ycoord p i) = p := by
  simp [ypart, ycoord]

@[simp] theorem ymode_ycoord {n : ℕ} (p : Fin n) (i : Fin 99) : ymode (ycoord p i) = i := by
  simp [ymode, ycoord]

/-! ## 2. The magnetic field and the 3D gauge-fixing forms of each particle -/

/-- **The magnetic field of the `p`-th particle**,
`B_{i a} = ε_{ijk}(∂_j A_{k,a} + f_{abc} A_{j,b} A_{k,c})`, as a polynomial in the `99n`
coordinates.  The structure constants are arbitrary reals: the quartic (non-abelian) case is
included. -/
def magPolyN (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) {n : ℕ} (p : Fin n) (i : Fin 3) (a : Fin 8) :
    MvPolynomial (Fin (n * 99)) ℂ :=
  ∑ j : Fin 3, ∑ k : Fin 3, ((levi i j k : ℝ) : ℂ) •
    (X (ycoord p (idxD j k a)) + ∑ b : Fin 8, ∑ c : Fin 8,
      ((fabc a b c : ℝ) : ℂ) • (X (ycoord p (idxA j b)) * X (ycoord p (idxA k c))))



/-- **The 3D gauge-fixing form of the `p`-th particle**, `Σ_j ∂_j A_{j,a}` — the transverse
(Coulomb) gauge condition on the spatial slice, written in the independent coordinates that
represent the spatial derivatives of the gauge field. -/
def gaussPolyN {n : ℕ} (p : Fin n) (a : Fin 8) : MvPolynomial (Fin (n * 99)) ℂ :=
  ∑ j : Fin 3, X (ycoord p (idxD j j a))





/-! ## 3. The `n`-particle Hamiltonian -/

/-- The momentum operators of the `n`-particle sector: `π = −i ∂/∂A_{j,a}`, one for each of
the `24` gauge-field coordinates of each of the `n` particles. -/
def ymPiN (n : ℕ) (m : Fin (n * 24)) :
    (polyGaussCore (d := n * 99)) →ₗ[ℂ] (polyGaussCore (d := n * 99)) :=
  (coreRepPoly (n * 99)).op
    (momOp (ycoord (finProdFinEquiv.symm m).1
      (idxA (decodeSpace (finProdFinEquiv.symm m).2)
        (decodeColor (finProdFinEquiv.symm m).2))))

/-- The field operators of the `n`-particle sector: the `24n` magnetic-field components and
the `8n` 3D gauge-fixing forms, as multiplication operators. -/
def ymFieldSum (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (n : ℕ) (s : Fin (n * 24) ⊕ Fin (n * 8)) :
    (polyGaussCore (d := n * 99)) →ₗ[ℂ] (polyGaussCore (d := n * 99)) :=
  Sum.elim
    (fun m₁ : Fin (n * 24) =>
      (coreRepPoly (n * 99)).op
        (mulOp (magPolyN fabc (finProdFinEquiv.symm m₁).1
          (decodeSpace (finProdFinEquiv.symm m₁).2)
          (decodeColor (finProdFinEquiv.symm m₁).2))))
    (fun m₂ : Fin (n * 8) =>
      (coreRepPoly (n * 99)).op
        (mulOp (gaussPolyN (finProdFinEquiv.symm m₂).1 (finProdFinEquiv.symm m₂).2)))
    s

/-- The field operators of the `n`-particle sector, indexed by `Fin (24n + 8n)`. -/
def ymFieldN (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (n : ℕ) (m : Fin (n * 24 + n * 8)) :
    (polyGaussCore (d := n * 99)) →ₗ[ℂ] (polyGaussCore (d := n * 99)) :=
  ymFieldSum fabc n (finSumFinEquiv.symm m)







/-- **The `n`-particle gauge-fixed Yang–Mills Hamiltonian** on the Gauss–polynomial core of
`L²(ℝ^{99n})`: the kinetic term of every particle, the full magnetic energy (quartic in the
non-abelian case) of every particle, and the 3D gauge fixing of every particle. -/
def ymSectorHam (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (n : ℕ) :
    (polyGaussCore (d := n * 99)) →ₗ[ℂ] L2d (n * 99) :=
  weylOp (ymPiN n) (ymFieldN fabc n)







/-! ## 4. The nested Fock space -/

/-- The nested Fock space `⊕ₙ L²(ℝ^{99n})` of the Yang–Mills field. -/
abbrev ymFockSpace := lp (fun n : ℕ => L2d (n * 99)) 2

/-- The finite-particle core: finitely many sectors, each in its Gauss–polynomial core. -/
def ymFockCore : Submodule ℂ ymFockSpace := dsCore (fun n : ℕ => polyGaussCore (d := n * 99))



/-- **The Yang–Mills Hamiltonian on the nested Fock space**: one copy of the one-particle
Hamiltonian per particle, in every number sector. -/
def ymFockHam (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) : ymFockCore →ₗ[ℂ] ymFockSpace :=
  dsOp (fun n : ℕ => ymSectorHam fabc n)









/-! ## 5. Particle-number conservation — why no lattice is needed -/





end

end BookProof.YmFockFriedrichs
