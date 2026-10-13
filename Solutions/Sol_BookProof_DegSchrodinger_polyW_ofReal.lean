-- Generated from ChapterDegSchrodingerCore.lean — solution of BookProof.DegSchrodinger.polyW_ofReal
import Mathlib
import Definitions.Def_ChapterDegSchrodingerCore
import Theorems.Thm_BookProof_QgHermiteFriedrichs_conj_polyEval
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterYangMillsHermite
open BookProof.DegSchrodinger




open MeasureTheory SchwartzMap MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.HermiteProductBasis
open BookProof.HermiteProductCore
open BookProof.QgHermiteFriedrichs
open BookProof.YangMillsHermite

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {q : MvPolynomial (Fin d) ℂ} (hq : RealCoeff q) (x : Vd d) :
    ((polyW q x : ℝ) : ℂ) = MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) q := by

  have hcp : cpoly q = q := hq
  have h : (starRingEnd ℂ) (MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) q)
      = MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) q := by
    rw [conj_polyEval, hcp]
  exact Complex.conj_eq_iff_re.mp h
