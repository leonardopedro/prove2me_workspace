-- Generated from ChapterHermiteGraphApprox.lean — solution of BookProof.HermiteGraphApprox.inner_pgLp_hamPolyL
import Mathlib
import Definitions.Def_ChapterHermiteGraphApprox
import Theorems.Thm_BookProof_HermiteGraphApprox_integral_conj_pgFun_hamPolyL
import Theorems.Thm_BookProof_HermiteGraphApprox_inner_pgLp_ae
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterDegKatoEsa
import Definitions.Def_ChapterDegEnergyEstimate
import Definitions.Def_ChapterHermiteLadderOrder
import Definitions.Def_ChapterConvolutionCalc
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
open BookProof.HermiteGraphApprox




open MeasureTheory SchwartzMap MvPolynomial Filter Topology
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.DegEnergy BookProof.HermiteLadder
open BookProof.ConvolutionCalc
open scoped ENNReal
open BookProof.HermiteProductCore
open BookProof.YangMillsHermite

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (S : Finset (Fin d)) {q : MvPolynomial (Fin d) ℂ}
    (hq : RealCoeff q) (p : MvPolynomial (Fin d) ℂ) {g : Vd d → ℂ}
    (hg : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) g) (hgc : HasCompactSupport g) {v w : L2d d}
    (hv : (v : Vd d → ℂ) =ᵐ[volume] g) (hw : (w : Vd d → ℂ) =ᵐ[volume] Lfun S (polyW q) g) :
    (inner ℂ (pgLp (hamPolyL S q p)) v : ℂ) = inner ℂ (pgLp p) w := by

  rw [inner_pgLp_ae hv, inner_pgLp_ae hw, integral_conj_pgFun_hamPolyL S hq p hg hgc]
