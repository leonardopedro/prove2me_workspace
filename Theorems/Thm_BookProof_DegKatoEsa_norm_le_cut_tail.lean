-- Generated from ChapterDegKatoEsa.lean — theorem BookProof.DegKatoEsa.norm_le_cut_tail
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterConvolutionCalc
import Definitions.Def_ChapterDegEnergyEstimate
import Definitions.Def_ChapterMollifierL2
import Mathlib
import Definitions.Def_ChapterDegKatoEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterScalaronCoreEsa
open BookProof.HermiteProductCore
open BookProof.ScalaronEsa
open BookProof.DegKatoEsa



open MeasureTheory SchwartzMap MvPolynomial Filter Topology
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.DegSchrodinger
open BookProof.ConvolutionCalc BookProof.DegEnergy BookProof.MollifierL2

noncomputable section

variable {d : ℕ}


theorem BookProof.DegKatoEsa.norm_le_cut_tail (W : Vd d → ℝ) (hWs : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) W)
    (hW1 : ∀ x, 1 ≤ W x) (S : Finset (Fin d)) {z : ℂ} (hz : z.re = 0) {u : L2d d}
    (hu : ∀ v : ccDomain (Vd d), (inner ℂ (ccHamS W hWs S v) u : ℂ)
      = z * inner ℂ ((v : L2d d)) u)
    {C : ℝ} (hC0 : 0 ≤ C) {N : ℕ} (hN : 1 ≤ N)
    (hdχ : ∀ j x, ‖dcoord j (cx (cut d (N : ℝ))) x‖ ≤ C / N) :
    ‖u‖ ≤ Real.sqrt (2 * S.card) * (C / N) * ‖u‖
      + (eLpNorm (({z : Vd d | ‖z‖ ≤ (N : ℝ)}ᶜ).indicator (fun x => ‖(u : Vd d → ℂ) x‖)) 2
          (volume : Measure (Vd d))).toReal := by sorry
