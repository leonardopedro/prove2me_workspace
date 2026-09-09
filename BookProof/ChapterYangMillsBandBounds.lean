import Mathlib
import BookProof.ChapterHermiteBandCalculusHigher
import BookProof.ChapterYangMillsAbelianFockEsa

/-!
# The Hermite matrix of the **full non-abelian** gauge-fixed Yang–Mills Hamiltonian:
# sparsity, band radius and entry bounds

The certificate seam of the Yang–Mills thread (`BookProof.ChapterSchurGershgorinGap`,
`BookProof.ChapterYangMillsCertificateSeam`) consumes matrix elements
`a_{jk} = ⟪b_j, H b_k⟫` of the one-particle Hamiltonian.  Until now nothing said, for the
*physical* Hamiltonian `f_{abc} ≠ 0`, which of those entries can be non-zero or how large
they are: the band calculus of `BookProof.ChapterHermiteBandCalculus` is a calculus of
quadratic symbols, and with non-zero structure constants the magnetic field
`B_{ia} = ε_{ijk}(∂_jA_{k,a} + f_{abc}A_{j,b}A_{k,c})` is cubic, so `B²` is quartic.

`BookProof.ChapterHermiteBandCalculusHigher` removes the degree restriction from the
*matrix-structure* half of the calculus.  This chapter applies it to Yang–Mills.

## What is proved

* `ymPoly fabc` — the polynomial-level Hamiltonian `½Σ_m π_m² + ½Σ_m B_m²` for an arbitrary
  real family of structure constants (the `f_{abc} = 0` case is `ymAbelianPoly`).
* `ymHermOp`, **`ymHermOp_eq`**, `ymHamiltonian_hermCore_eq'` — on the finite-mode domain of
  the product Hermite basis it *is* `ymHamiltonian (coreRepHerm e) fabc`, the Hamiltonian of
  `BookProof.ChapterYangMillsHermite`.
* `isBandDeg2_magMulOp` — multiplication by the full cubic magnetic polynomial is a band
  operator of order `2` (each of its monomials has degree at most `2` in the coordinates).
* **`isBandDeg4_ymPoly`** — hence the Yang–Mills Hamiltonian is a band operator of order `4`.
* `gradedBand_of_isBandR` — the general seam: a band operator of radius `r` and order `m`
  has a Hermite matrix with boundedly many entries per column, band radius `r` in the
  degree, and entries bounded by `C·√(deg+1)^m`.
* **`ym_hermCol_band_bounds`** — the headline, for every real `f_{abc}`: there are `M` and
  `C` such that every column of the Hermite matrix of the gauge-fixed Yang–Mills
  Hamiltonian has at most `M` non-zero entries, an entry `⟪ψ_{e j}, H ψ_{e k}⟫` vanishes
  unless `|deg (e j) − deg (e k)| ≤ 4`, and `|⟪ψ_{e j}, H ψ_{e k}⟫| ≤ C (deg (e k) + 1)²`.
* `isHermCol_ymHermCol` — the matrix is Hermitian.

## Why this is the certificate data

A certificate for a gap has to enumerate matrix elements.  The statement above says the
enumeration is *finite and complete*: outside a window of `4` degrees around the column
index every entry is zero, inside it there are at most `M` of them, and each is bounded a
priori by `C(deg+1)²`.  That is exactly the input shape of the Gershgorin/Schur criteria of
`BookProof.ChapterSchurGershgorinGap`.

## Honest boundary

Nothing here is a self-adjointness statement for `f_{abc} ≠ 0`: the weighted Schur gate that
turns a band matrix into essential self-adjointness of `dΓ` is available only for order `≤ 2`
(with an order-`m` symbol and any weight that is a function of the degree, the commutator
term of the gate grows like `deg^{m/2−1}`).  And nothing here is a mass gap: the numerical
values of the entries are not computed, only their support and their size.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.YangMillsBandBounds

noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.HermiteBandHigher BookProof.QuadFockEsa
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic BookProof.YangMillsAbelianEsa
open BookProof.YangMillsFriedrichs BookProof.YmAbelianFock
open BookProof.NavierStokesFlow.DifferentialL2 BookProof.HermiteRelative

/-! ## The polynomial-level Hamiltonian for arbitrary structure constants -/

/-- The polynomial-level gauge-fixed Yang–Mills Hamiltonian `½ Σ_m π_m² + ½ Σ_m B_m²`, with
the **full cubic** magnetic polynomial. -/
def ymPoly (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) :
    MvPolynomial (Fin 99) ℂ →ₗ[ℂ] MvPolynomial (Fin 99) ℂ :=
  ((1 / 2 : ℝ) : ℂ) •
    ((∑ m : Fin 24, (YangMillsHermite.momOp (ymMomIdx m)).comp
        (YangMillsHermite.momOp (ymMomIdx m)))
      + ∑ m : Fin 24, (mulOp (magPoly fabc (decodeSpace m) (decodeColor m))).comp
          (mulOp (magPoly fabc (decodeSpace m) (decodeColor m))))

theorem ymPoly_zero : ymPoly 0 = ymAbelianPoly := rfl

/-- The one-particle Yang–Mills Hamiltonian as an endomorphism of the finite-mode domain of
the product Hermite basis. -/
def ymHermOp (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) :
    finiteModeDomain (hermBasisN e) →ₗ[ℂ] finiteModeDomain (hermBasisN e) :=
  weylOpDom (piOps (coreRepHerm e)) (magOps (coreRepHerm e) fabc)

set_option maxHeartbeats 4000000 in
-- the `L²` coercions of the Gauss–polynomial core and the `24` Weyl-ordered squares of the
-- Yang–Mills Hamiltonian make the defeq checks of this identification expensive
/-- It is the transport of the polynomial-level Hamiltonian. -/
theorem ymHermOp_eq (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) :
    ymHermOp e fabc = (coreRepHerm e).op (ymPoly fabc) := by
  have h1 : (∑ m : Fin 24, (piOps (coreRepHerm e) m).comp (piOps (coreRepHerm e) m))
      = ∑ m : Fin 24, (coreRepHerm e).op
          ((YangMillsHermite.momOp (ymMomIdx m)).comp (YangMillsHermite.momOp (ymMomIdx m))) :=
    Finset.sum_congr rfl fun m _ => by rw [coreRep_op_comp]; rfl
  have h2 : (∑ m : Fin 24, (magOps (coreRepHerm e) fabc m).comp (magOps (coreRepHerm e) fabc m))
      = ∑ m : Fin 24, (coreRepHerm e).op
          ((mulOp (magPoly fabc (decodeSpace m) (decodeColor m))).comp
            (mulOp (magPoly fabc (decodeSpace m) (decodeColor m)))) :=
    Finset.sum_congr rfl fun m _ => by rw [coreRep_op_comp]; rfl
  rw [ymHermOp, weylOpDom, ymPoly, coreRep_op_smul, coreRep_op_add,
    coreRep_op_sum, coreRep_op_sum, h1, h2]

/-- The Yang–Mills Hamiltonian of `BookProof.ChapterYangMillsHermite`, on the Hermite core,
is this operator. -/
theorem ymHamiltonian_hermCore_eq' (e : ℕ ≃ (Fin 99 →₀ ℕ))
    (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) :
    ymHamiltonian (coreRepHerm e) fabc
      = (finiteModeDomain (hermBasisN e)).subtype.comp (ymHermOp e fabc) := rfl

/-- Its matrix in the product Hermite basis. -/
def ymHermCol (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) : ℕ → (ℕ →₀ ℂ) :=
  opCol (hermBasisN e) (ymHermOp e fabc)

theorem ymHermCol_eq (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) :
    ymHermCol e fabc = hermCol e (ymPoly fabc) := by
  rw [ymHermCol, ymHermOp_eq, hermCol]

theorem isHermCol_ymHermCol (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) :
    IsHermCol (ymHermCol e fabc) :=
  isHermCol_opCol (ymHamiltonian_symmetricOn (coreRepHerm e) fabc)

/-! ## The order of the Yang–Mills Hamiltonian -/

/-- Multiplication by the **full cubic** magnetic polynomial is a band operator of order `2`:
its monomials are the single derivative coordinates `∂_jA_{k,a}` and the quadratic products
`A_{j,b}A_{k,c}`. -/
theorem isBandR2_magMulOp (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (i : Fin 3) (a : Fin 8) :
    IsBandR 2 2 (mulOp (magPoly fabc i a)) := by
  rw [magPoly, mulOp_sum]
  refine IsBandR.sum _ _ fun j _ => ?_
  rw [mulOp_sum]
  refine IsBandR.sum _ _ fun k _ => ?_
  rw [mulOp_smul]
  refine IsBandR.smul _ ?_
  rw [mulOp_add']
  refine IsBandR.add ?_ ?_
  · rw [mulOp_eq_mulXPoly]
    exact ((isBandR1_mulXPoly _).le (by norm_num)).monoR (by norm_num)
  · rw [mulOp_sum]
    refine IsBandR.sum _ _ fun b _ => ?_
    rw [mulOp_sum]
    refine IsBandR.sum _ _ fun c _ => ?_
    rw [mulOp_smul]
    refine IsBandR.smul _ ?_
    rw [mulOp_mul, mulOp_eq_mulXPoly, mulOp_eq_mulXPoly]
    exact (isBandR1_mulXPoly _).comp (isBandR1_mulXPoly _)

theorem isBandDeg2_magMulOp (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (i : Fin 3) (a : Fin 8) :
    IsBandDeg 2 (mulOp (magPoly fabc i a)) := (isBandR2_magMulOp fabc i a).isBandDeg

/-- **The gauge-fixed Yang–Mills Hamiltonian is a band operator of radius `4` and order `4`**
in the product Hermite basis, for every real family of structure constants. -/
theorem isBandR4_ymPoly (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) : IsBandR 4 4 (ymPoly fabc) := by
  rw [ymPoly]
  refine IsBandR.smul _ (IsBandR.add ?_ ?_)
  · refine IsBandR.sum _ _ fun m _ => ?_
    have hmom : IsBandR 1 1 (YangMillsHermite.momOp (ymMomIdx m)) := by
      rw [← momPoly_eq_ymMomOp]
      exact isBandR1_momPoly _
    exact ((hmom.comp hmom).le (by norm_num)).monoR (by norm_num)
  · refine IsBandR.sum _ _ fun m _ => ?_
    exact (isBandR2_magMulOp fabc (decodeSpace m) (decodeColor m)).comp
      (isBandR2_magMulOp fabc (decodeSpace m) (decodeColor m))

theorem isBandDeg4_ymPoly (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) : IsBandDeg 4 (ymPoly fabc) :=
  (isBandR4_ymPoly fabc).isBandDeg

/-! ## The matrix seam for an arbitrary order -/

/-- **An order-`m` band operator has a graded band matrix in the enumerated product Hermite
basis**: boundedly many entries per column, a finite band radius in the degree, and entries
bounded by `C·√(deg+1)^m`. -/
theorem gradedBand_of_isBandR {d r m : ℕ} (e : ℕ ≃ (Fin d →₀ ℕ))
    {T : Module.End ℂ (MvPolynomial (Fin d) ℂ)} (h : IsBandR r m T) :
    ∃ (M : ℕ) (C : ℝ), 0 ≤ C ∧
      (∀ k, (hermCol e T k).support.card ≤ M) ∧
      (∀ k, ∀ j ∈ (hermCol e T k).support,
        (((e j).degree : ℤ) - ((e k).degree : ℤ)).natAbs ≤ r) ∧
      (∀ k j, ‖hermCol e T k j‖ ≤ C * Real.sqrt (((e k).degree : ℝ) + 1) ^ m) := by
  classical
  obtain ⟨M, C, hC, hB⟩ := h
  choose F hFrep hFcard hFband hFcoef using fun α => hB α
  refine ⟨M, C, hC, ?_, ?_, ?_⟩
  · intro k
    have hsub : ∀ j ∈ (hermCol e T k).support, e j ∈ (F (e k)).support := by
      intro j hj
      have hne : hermCol e T k j ≠ 0 := Finsupp.mem_support_iff.mp hj
      rw [hermCol_eq_coef e (hFrep (e k)) j] at hne
      exact Finsupp.mem_support_iff.mpr hne
    refine le_trans (Finset.card_le_card_of_injOn e hsub ?_) (hFcard (e k))
    exact fun a _ b _ hab => e.injective hab
  · intro k j hj
    have hne : hermCol e T k j ≠ 0 := Finsupp.mem_support_iff.mp hj
    rw [hermCol_eq_coef e (hFrep (e k)) j] at hne
    exact hFband (e k) (e j) (Finsupp.mem_support_iff.mpr hne)
  · intro k j
    rw [hermCol_eq_coef e (hFrep (e k)) j]
    exact hFcoef (e k) (e j)

/-! ## The headline -/

/-- **The Hermite matrix of the full non-abelian gauge-fixed Yang–Mills Hamiltonian**: every
column has at most `M` non-zero entries, entries vanish outside a band of radius `r` in the
total degree, and every entry is bounded by `C (deg + 1)²`. -/
theorem ym_hermCol_band_bounds (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) :
    ∃ (M : ℕ) (C : ℝ), 0 ≤ C ∧
      (∀ k, (ymHermCol e fabc k).support.card ≤ M) ∧
      (∀ k, ∀ j ∈ (ymHermCol e fabc k).support,
        (((e j).degree : ℤ) - ((e k).degree : ℤ)).natAbs ≤ 4) ∧
      (∀ k j, ‖ymHermCol e fabc k j‖ ≤ C * (((e k).degree : ℝ) + 1) ^ 2) := by
  obtain ⟨M, C, hC, hcard, hband, hent⟩ :=
    gradedBand_of_isBandR e (isBandR4_ymPoly fabc)
  refine ⟨M, C, hC, ?_, ?_, ?_⟩
  · intro k; rw [ymHermCol_eq]; exact hcard k
  · intro k j hj; rw [ymHermCol_eq] at hj; exact hband k j hj
  · intro k j
    have hsq : Real.sqrt (((e k).degree : ℝ) + 1) ^ 4 = (((e k).degree : ℝ) + 1) ^ 2 := by
      have h : Real.sqrt (((e k).degree : ℝ) + 1) ^ 2 = ((e k).degree : ℝ) + 1 :=
        Real.sq_sqrt (by positivity)
      calc Real.sqrt (((e k).degree : ℝ) + 1) ^ 4
          = (Real.sqrt (((e k).degree : ℝ) + 1) ^ 2) ^ 2 := by ring
        _ = (((e k).degree : ℝ) + 1) ^ 2 := by rw [h]
    rw [ymHermCol_eq, ← hsq]
    exact hent k j

end

end BookProof.YangMillsBandBounds
