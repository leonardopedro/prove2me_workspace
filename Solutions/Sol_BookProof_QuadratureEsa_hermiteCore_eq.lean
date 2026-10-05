-- Generated from ChapterQuadratureEsa.lean — solution of BookProof.QuadratureEsa.hermiteCore_eq
import Mathlib
import Definitions.Def_ChapterQuadratureEsa
open BookProof.QuadratureEsa




open MeasureTheory MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (a : Fin d →₀ ℕ) (h : hermiteMvLp (d := d) a ∈ polyGaussCore (d := d)) :
    (⟨hermiteMvLp a, h⟩ : polyGaussCore (d := d)) = hermiteCore a := Subtype.ext (hermiteCore_coe a).symm
